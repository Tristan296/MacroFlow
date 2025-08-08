import Foundation

struct PlanningTask: Hashable {
    let title: String
    let durationMinutes: Int
    let priority: Int // 1 (highest) - 5 (lowest)
}

struct PlannedBlock: Hashable {
    let title: String
    let interval: DateInterval
}

final class PlanningService {
    static let shared = PlanningService()
    private init() {}

    func planDay(date: Date, tasks: [PlanningTask], busy: [DateInterval]) -> [PlannedBlock] {
        let sorted = tasks.sorted { lhs, rhs in
            if lhs.priority != rhs.priority { return lhs.priority < rhs.priority }
            return lhs.durationMinutes < rhs.durationMinutes
        }
        let free = computeFreeIntervals(date: date, busy: busy)
        var plan: [PlannedBlock] = []
        var freeQueue = free
        for task in sorted {
            guard !freeQueue.isEmpty else { break }
            var minutesRemaining = task.durationMinutes
            while minutesRemaining > 0, !freeQueue.isEmpty {
                let slot = freeQueue.removeFirst()
                let slotMinutes = Int(slot.duration / 60)
                if slotMinutes <= 0 { continue }
                let usedMinutes = min(slotMinutes, minutesRemaining)
                let end = slot.start.addingTimeInterval(TimeInterval(usedMinutes * 60))
                plan.append(PlannedBlock(title: task.title, interval: DateInterval(start: slot.start, end: end)))
                minutesRemaining -= usedMinutes
                if usedMinutes < slotMinutes {
                    // Put the leftover back as a new free slot
                    freeQueue.insert(DateInterval(start: end, end: slot.end), at: 0)
                }
            }
        }
        return plan
    }

    private func computeFreeIntervals(date: Date, busy: [DateInterval]) -> [DateInterval] {
        let calendar = Calendar.current
        let dayStart = calendar.startOfDay(for: date)
        guard let workStart = calendar.date(byAdding: .hour, value: 9, to: dayStart),
              let workEnd = calendar.date(byAdding: .hour, value: 18, to: dayStart) else { return [] }
        var free = [DateInterval(start: workStart, end: workEnd)]
        for interval in busy.sorted(by: { $0.start < $1.start }) {
            free = free.flatMap { split(free: $0, by: interval) }
        }
        return free.filter { $0.duration >= 15 * 60 }
    }

    private func split(free: DateInterval, by busy: DateInterval) -> [DateInterval] {
        // No overlap
        if busy.end <= free.start || busy.start >= free.end { return [free] }
        var result: [DateInterval] = []
        if busy.start > free.start {
            result.append(DateInterval(start: free.start, end: busy.start))
        }
        if busy.end < free.end {
            result.append(DateInterval(start: busy.end, end: free.end))
        }
        return result
    }
}