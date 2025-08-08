import Foundation
struct Trip: Identifiable {
    let id = UUID()
    let destination: String
    let description: String
    let tags: [String]
    let location: String
    let dateRange: String
    let progress: Double
    let status: String
    let completed: Int
    let remaining: Int
    let overdue: Int
    let nextTask: Task
    let estimatedTimeRemaining: Double
}

struct Task {
    let title: String
    let dueDate: String
    let priority: String // "HIGH", "MEDIUM", etc.
}
