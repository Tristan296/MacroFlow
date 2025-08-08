import Foundation
import EventKit

final class AppleCalendarService {
    static let shared = AppleCalendarService()
    private let eventStore = EKEventStore()
    private init() {}

    func requestAccess() async throws {
        let status = EKEventStore.authorizationStatus(for: .event)
        if status == .authorized { return }
        try await withCheckedThrowingContinuation { (cont: CheckedContinuation<Void, Error>) in
            eventStore.requestAccess(to: .event) { granted, error in
                if let error = error { cont.resume(throwing: error); return }
                if granted { cont.resume() } else {
                    cont.resume(throwing: NSError(domain: "AppleCalendar", code: 1, userInfo: [NSLocalizedDescriptionKey: "Calendar access denied"]))
                }
            }
        }
    }

    func createEvent(title: String, notes: String? = nil, startDate: Date, endDate: Date, calendar: EKCalendar? = nil) throws {
        let event = EKEvent(eventStore: eventStore)
        event.title = title
        event.notes = notes
        event.startDate = startDate
        event.endDate = endDate
        event.calendar = calendar ?? eventStore.defaultCalendarForNewEvents
        try eventStore.save(event, span: .thisEvent, commit: true)
    }

    func fetchBusyIntervals(for date: Date) throws -> [DateInterval] {
        let dayStart = Calendar.current.startOfDay(for: date)
        guard let dayEnd = Calendar.current.date(byAdding: .day, value: 1, to: dayStart) else { return [] }
        let predicate = eventStore.predicateForEvents(withStart: dayStart, end: dayEnd, calendars: nil)
        let events = eventStore.events(matching: predicate)
        return events.map { DateInterval(start: $0.startDate, end: $0.endDate) }
    }
}

// Stubs to be implemented with Google SDKs (Google Sign-In, GoogleAPIClientForREST)
final class GoogleCalendarService {
    func insertEvent(title: String, notes: String?, startDate: Date, endDate: Date) async throws {
        // TODO: Implement using Google Calendar API
    }
}

final class GoogleTasksService {
    func insertTask(title: String, notes: String?, due: Date?) async throws {
        // TODO: Implement using Google Tasks API
    }
}