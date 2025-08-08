//
//  TripDetailView.swift
//  MacroFlow
//
//  Created by Tristan Norbury on 8/8/2025.
//


import SwiftUI

struct TripDetailView: View {
    let trip: Trip

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("\(trip.destination) • \(trip.dateRange.start.formatted(date: .abbreviated, time: .omitted)) - \(trip.dateRange.end.formatted(date: .abbreviated, time: .omitted))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                ProgressView("Overall Progress", value: trip.progress, total: 1.0)
                    .padding(.top)

                // Add one or more TripSectionViews here
                TripSectionView(sectionTitle: "Flights", progress: 50)
                TripSectionView(sectionTitle: "Accommodation", progress: 80)
                TripSectionView(sectionTitle: "Activities", progress: 30)

                Spacer()
            }
            .padding()
        }
        .navigationTitle(trip.title)
    }
}
