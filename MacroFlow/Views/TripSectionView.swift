struct TripSectionView: View {
    var sectionTitle: String
    var progress: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(sectionTitle)
                    .font(.headline)
                Spacer()
                Text("\(Int(progress))%")
            }

            ProgressView(value: progress / 100)
                .accentColor(.purple)

            HStack(spacing: 12) {
                ActionButton(title: "AI Regenerate", icon: "arrow.clockwise")
                ActionButton(title: "AI Suggestions", icon: "lightbulb")
                ActionButton(title: "Search & Book", icon: "magnifyingglass")
                ActionButton(title: "Add Subtask", icon: "plus")
            }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
}

struct ActionButton: View {
    let title: String
    let icon: String

    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: icon)
                Text(title)
                    .font(.caption)
            }
            .padding(6)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 1)
        }
    }
}
