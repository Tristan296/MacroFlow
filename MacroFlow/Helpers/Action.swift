func handleAction(_ type: TripActionType) {
    switch type {
    case .regenerate:
        print("Regenerating content with AI...")
        // call your regenerate AI function here
    case .suggest:
        print("Showing AI suggestions...")
    case .searchAndBook:
        print("Opening search and book flow...")
    case .addSubtask:
        print("Adding new subtask...")
    }
}
