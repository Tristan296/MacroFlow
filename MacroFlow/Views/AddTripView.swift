import SwiftUI

struct AddTripView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var title = ""
    @State private var destination = ""
    @State private var startDate = Date()
    @State private var endDate = Date().addingTimeInterval(86400 * 7)

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Trip Info")) {
                    TextField("Trip Title", text: $title)
                    TextField("Destination", text: $destination)
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                }
            }
            .navigationTitle("New Trip")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        let newTrip = Trip(title: title, destination: destination, startDate: startDate, endDate: endDate)
                        modelContext.insert(newTrip)
                        dismiss()
                    }
                    .disabled(title.isEmpty || destination.isEmpty)
                }
            }
        }
    }
}
