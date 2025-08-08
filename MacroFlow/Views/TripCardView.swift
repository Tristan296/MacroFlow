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
            Text(trip.description)
                .font(.subheadline)
                .foregroundColor(.secondary)

            // Tags
            HStack {
                ForEach(trip.tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(6)
                }
            }

            // Location and Dates
            HStack(spacing: 10) {
                Label(trip.location, systemImage: "mappin.and.ellipse")
                Label(trip.dateRange, systemImage: "calendar")
            }
            .font(.caption)
            .foregroundColor(.gray)

            // Progress Bar
            VStack(alignment: .leading) {
                HStack {
                    Text("Overall Progress")
                        .font(.subheadline)
                    Spacer()
                    Text("\(Int(trip.progress))%")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(trip.status)
                        .font(.caption)
                        .padding(5)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5)
                }

                ProgressView(value: trip.progress / 100)
                    .accentColor(.blue)
            }

            // Task Stats
            HStack {
                TripStatView(label: "Completed", value: trip.completed, color: .green)
                TripStatView(label: "Remaining", value: trip.remaining, color: .blue)
                TripStatView(label: "Overdue", value: trip.overdue, color: .red)
            }

            Divider()

            // Next Task
            VStack(alignment: .leading, spacing: 4) {
                Text("NEXT TASK")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)

                HStack {
                    Label(trip.nextTask.title, systemImage: "airplane.departure")
                    Spacer()
                    if trip.nextTask.priority == "HIGH" {
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
                    Text("Due \(trip.nextTask.dueDate)")
                        .font(.caption)
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
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 3)
    }
}

struct TripStatView: View {
    let label: String
    let value: Int
    let color: Color

    var body: some View {
        VStack {
            Text("\(value)")
                .font(.title3)
                .foregroundColor(color)
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}
