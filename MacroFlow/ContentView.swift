import SwiftUI
import SwiftData


struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var trips: [Trip]
    @State private var showingAddTrip = false
  
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(trips) { trip in
                    // Precompute date strings
                    let startDateString = trip.dateRange.start.formatted(date: .abbreviated, time: .omitted)
                    let endDateString = trip.dateRange.end.formatted(date: .abbreviated, time: .omitted)
                    let dateRangeString = "\(startDateString) to \(endDateString)"

                    NavigationLink(destination: TripDetailView(trip: trip)) {
                        // Use your TripCardView here to show trip summary
                        TripCardView(trip: trip)
                    }
                }
                .onDelete(perform: deleteTrips)
            }
            .navigationTitle("My Trips")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: { showingAddTrip = true }) {
                        Label("Add Trip", systemImage: "plus")
                    }
                }
            }
        } detail: {
            // Show detail for the selected trip or placeholder text
            if let selectedTrip = trips.first {
                TripDetailView(trip: selectedTrip)
            } else {
                Text("Select a trip")
                    .foregroundColor(.secondary)
            }
        }
        .sheet(isPresented: $showingAddTrip) {
            AddTripView()
        }
    }

    private func deleteTrips(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(trips[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Trip.self, inMemory: true)
}
