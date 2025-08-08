import Foundation
import SwiftData

@Model
class Trip: Identifiable {
    @Attribute(.unique) var id: UUID
    var title: String {
        "Trip to \(destination)"
    }
    var destination: String
    var tripDescription: String
    var tags: [String]
    var location: String
    var dateRange: DateInterval
    var progress: Double
    var status: String
    var completedTasks: Int
    var remainingTasks: Int
    var overdueTasks: Int
    var nextTask: TripTask?
    var estimatedTimeRemaining: TimeInterval

    init(
        id: UUID = UUID(),
        title: String = "",
        destination: String,
        tripDescription: String,
        tags: [String] = [],
        location: String,
        dateRange: DateInterval,
        progress: Double = 0.0,
        status: String = "Planning",
        completedTasks: Int = 0,
        remainingTasks: Int = 0,
        overdueTasks: Int = 0,
        nextTask: TripTask? = nil,
        estimatedTimeRemaining: TimeInterval = 0.0
    ) {
        self.id = id
        self.destination = destination
        self.tripDescription = tripDescription
        self.tags = tags
        self.location = location
        self.dateRange = dateRange
        self.progress = progress
        self.status = status
        self.completedTasks = completedTasks
        self.remainingTasks = remainingTasks
        self.overdueTasks = overdueTasks
        self.nextTask = nextTask
        self.estimatedTimeRemaining = estimatedTimeRemaining
    }
}


enum TripActionType {
    case regenerate
    case suggest
    case searchAndBook
    case addSubTask
    
    var title: String {
        switch self {
            case .regenerate: return "AI Regenerate"
            case .suggest: return "AI Suggestions"
            case .searchAndBook: return "Search & Book"
            case .addSubTask: return "Add SubTask"
        }
    }
    
    var icon: String {
        switch self {
            case .regenerate: return "arrow.clockwise"
            case .suggest: return "lightbulb"
            case .searchAndBook: return "magnifyingglass"
            case .addSubTask: return "plus"
        }
    }
}


