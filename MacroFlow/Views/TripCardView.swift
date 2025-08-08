//
//  TripCardView.swift
//  MacroFlow
//
//  Created by Tristan Norbury on 8/8/2025.
//


import SwiftUI

struct TripCardView: View {
    var trip: Trip

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Destination
            Text(trip.destination)
                .font(.title2)
                .fontWeight(.bold)

            // Description
            Text(trip.tripDescription)
                .font(.subheadline)
                .foregroundColor(.secondary)

            // Tags
            HStack {
                ForEach(trip.tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Capsule().fill(Color.gray.opacity(0.15)))
                }
            }

            // Location and Dates
            HStack(spacing: 10) {
                Label(trip.location, systemImage: "mappin.and.ellipse")
                Label(
                    "\(trip.dateRange.start.formatted(date: .abbreviated, time: .omitted)) - \(trip.dateRange.end.formatted(date: .abbreviated, time: .omitted))",
                    systemImage: "calendar"
                )

            }
            .font(.caption)
            .foregroundColor(.gray)

            // Progress Bar
            VStack(alignment: .leading) {
                HStack {
                    Text("Overall Progress")
                        .font(.subheadline)
                    Spacer()
                    Text("\(Int(trip.progress * 100))%")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(trip.status)
                        .font(.caption)
                        .padding(5)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5)
                }

                ProgressView(value: trip.progress, total: 1.0)
                    .tint(.blue)
            }

            // Task Stats
            HStack {
                TripStatView(label: "Completed", value: trip.completedTasks, color: .green)
                TripStatView(label: "Remaining", value: trip.remainingTasks, color: .blue)
                TripStatView(label: "Overdue", value: trip.overdueTasks, color: .red)
            }

            Divider()

            // Next Task
            VStack(alignment: .leading, spacing: 4) {
                Text("NEXT TASK")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)

                HStack {
                    Label(trip.nextTask?.title ?? "No next task", systemImage: "airplane.departure")
                    Spacer()
                    if trip.nextTask?.priority.uppercased() == "HIGH" {
                        Text("HIGH")
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.red, lineWidth: 1)
                            )
                    }
                }

                HStack(spacing: 6) {
                    Image(systemName: "clock")
                        .font(.caption)
                    if let nextTask = trip.nextTask {
                        Text("Due \(nextTask.dueDate.formatted(date: .abbreviated, time: .omitted))")
                            .font(.caption)

                    }
                    Image(systemName: "exclamationmark.triangle")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }

            // Est. Time Remaining
            Text("Est. time remaining: \(String(format: "%.1f", trip.estimatedTimeRemaining)) hours")
                .font(.footnote)
                .fontWeight(.medium)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.black.opacity(0.05))
        )
        .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
    }
}

func dateFromString(_ string: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.date(from: string) ?? Date()
}


#Preview {
    let start = dateFromString("2021-09-01")
    let end = dateFromString("2021-09-10")
    let dateInterval = DateInterval(start: start, end: end)

    TripCardView(trip: Trip(
        destination: "Tokyo, Japan",
        tripDescription: "Cultural exploration and business meetings",
        tags: ["Business", "Culture", "Solo"],
        location: "Tokyo, Japan",
        dateRange: dateInterval,
        progress: 0.54,
        status: "In Progress",
        completedTasks: 8,
        remainingTasks: 8,
        overdueTasks: 1,
        nextTask: TripTask(
            title: "Book return flight",
            dueDate: dateFromString("2021-10-10"),
            priority: "HIGH"
        ),
        estimatedTimeRemaining: 6.5
    ))
}
