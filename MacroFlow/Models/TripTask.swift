import Foundation

struct TripTask: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    var dueDate: Date
    var priority: Int // 1: High, 2: Medium, 3: Low
    var isCompleted: Bool

    init(
        id: UUID = UUID(),
        title: String,
        dueDate: Date,
        priority: Int = 2,
        isCompleted: Bool = false
    ) {
        self.id = id
        self.title = title
        self.dueDate = dueDate
        self.priority = priority
        self.isCompleted = isCompleted
    }
}
