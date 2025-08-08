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
