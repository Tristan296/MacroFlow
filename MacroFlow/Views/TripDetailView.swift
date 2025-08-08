//
//  TripDetailView.swift
//  MacroFlow
//
//  Created by Tristan Norbury on 8/8/2025.
//


import SwiftUI

struct TripDetailView: View {
    let trip: Trip
    @State private var suggestions: [ActivitySuggestion] = []
    @State private var isPlanning = false
    @State private var planResultMessage: String? = nil

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("\(trip.destination) • \(trip.dateRange.start.formatted(date: .abbreviated, time: .omitted)) - \(trip.dateRange.end.formatted(date: .abbreviated, time: .omitted))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                HStack(spacing: 12) {
                    Button {
                        Task { _ = try? await FlightService.shared.searchFlights(origin: "Home", destination: trip.destination, departDate: trip.dateRange.start, returnDate: trip.dateRange.end) }
                    } label: {
                        Label("Search Flights", systemImage: "airplane")
                    }
                    Button { MapsService.shared.openMaps(query: trip.destination, provider: .apple) } label: {
                        Label("Open in Maps", systemImage: "map")
                    }
                    Button { MapsService.shared.openMaps(query: trip.destination, provider: .google) } label: {
                        Label("Open in Google Maps", systemImage: "mappin")
                    }
                    Button(action: autoPlanToday) {
                        if isPlanning {
                            ProgressView().controlSize(.small)
                        } else {
                            Label("Auto Plan Today", systemImage: "calendar.badge.plus")
                        }
                    }
                    .disabled(isPlanning)
                }
                .buttonStyle(.bordered)
                .labelStyle(.titleAndIcon)

                ProgressView("Overall Progress", value: trip.progress, total: 1.0)
                    .padding(.top)

                // Suggestions
                if !suggestions.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Suggestions")
                            .font(.headline)
                        ForEach(suggestions) { s in
                            HStack(alignment: .top, spacing: 8) {
                                Image(systemName: "lightbulb")
                                VStack(alignment: .leading) {
                                    Text("\(s.category): \(s.title)")
                                        .font(.subheadline)
                                    if let notes = s.notes { Text(notes).font(.caption).foregroundColor(.secondary) }
                                }
                            }
                        }
                    }
                }

                // Sections
                TripSectionView(sectionTitle: "Flights", progress: 50)
                TripSectionView(sectionTitle: "Accommodation", progress: 80)
                TripSectionView(sectionTitle: "Activities", progress: 30)

                Spacer()
            }
            .padding()
            .task {
                let base = SuggestionService.shared.defaultSuggestions(for: trip.destination)
                suggestions = base
            }
        }
        .alert(planResultMessage ?? "", isPresented: Binding(get: { planResultMessage != nil }, set: { if !$0 { planResultMessage = nil } })) {
            Button("OK", role: .cancel) {}
        }
        .navigationTitle(trip.title)
    }

    @MainActor
    private func autoPlanToday() {
        isPlanning = true
        Task {
            defer { isPlanning = false }
            do {
                try await AppleCalendarService.shared.requestAccess()
                let busy = try AppleCalendarService.shared.fetchBusyIntervals(for: Date())
                let tasks: [PlanningTask] = [
                    PlanningTask(title: "Book flights", durationMinutes: 60, priority: 1),
                    PlanningTask(title: "Research accommodation", durationMinutes: 45, priority: 2),
                    PlanningTask(title: "Draft itinerary", durationMinutes: 90, priority: 3)
                ]
                let plan = PlanningService.shared.planDay(date: Date(), tasks: tasks, busy: busy)
                for block in plan {
                    try AppleCalendarService.shared.createEvent(title: block.title, notes: "Auto-planned by MacroFlow", startDate: block.interval.start, endDate: block.interval.end, calendar: nil)
                }
                planResultMessage = "Planned \(plan.count) blocks to Apple Calendar for today."
            } catch {
                planResultMessage = "Failed to plan: \(error.localizedDescription)"
            }
        }
    }
}
