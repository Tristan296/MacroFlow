import SwiftUI

struct TripDetailView: View {
    let trip: Trip

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(trip.title)
                .font(.largeTitle)
                .bold()

            Text("\(trip.destination) • \(trip.startDate.formatted(date: .abbreviated, time: .omitted)) - \(trip.endDate.formatted(date: .abbreviated, time: .omitted))")
                .font(.subheadline)
                .foregroundColor(.secondary)

            ProgressView("Overall Progress", value: trip.progress)
                .padding(.top)

            Spacer()
        }
        .padding()
        .navigationTitle(trip.title)
    }
}
