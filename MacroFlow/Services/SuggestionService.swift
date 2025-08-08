import Foundation

struct ActivitySuggestion: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let category: String // Hiking, Food, Accommodation
    let notes: String?
}

final class SuggestionService {
    static let shared = SuggestionService()
    private init() {}

    func defaultSuggestions(for destination: String) -> [ActivitySuggestion] {
        [
            ActivitySuggestion(title: "Best local ramen spots", category: "Local food", notes: "Explore neighborhoods near city center"),
            ActivitySuggestion(title: "Sunset viewpoint hike", category: "Hiking", notes: "2-3 hours, bring water"),
            ActivitySuggestion(title: "Boutique ryokan", category: "Accommodation", notes: "Onsen access preferred")
        ]
    }

    func aiSuggestions(goal: String, destination: String, interests: [String]) async -> [ActivitySuggestion] {
        do {
            let plan = try await AIService.shared.generateTripPlan(goal: goal, destination: destination, budgetRange: nil, startDate: Date(), endDate: Date().addingTimeInterval(86400*7), interests: interests)
            return plan.suggestedTasks.map { ActivitySuggestion(title: $0, category: "AI", notes: nil) }
        } catch {
            return defaultSuggestions(for: destination)
        }
    }
}