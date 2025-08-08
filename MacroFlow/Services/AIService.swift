import Foundation

struct TripPlan: Codable {
    let summary: String
    let suggestedTasks: [String]
}

final class AIService {
    static let shared = AIService()
    private init() {}

    private var apiKey: String? {
        ProcessInfo.processInfo.environment["OPENAI_API_KEY"]
    }

    func generateTripPlan(goal: String, destination: String, budgetRange: String?, startDate: Date, endDate: Date, interests: [String]) async throws -> TripPlan {
        if let key = apiKey, !key.isEmpty {
            return try await callOpenAI(goal: goal, destination: destination, budgetRange: budgetRange, startDate: startDate, endDate: endDate, interests: interests)
        } else {
            return TripPlan(
                summary: "Plan for \(destination): balance work and leisure, explore local cuisine and 1-2 hikes.",
                suggestedTasks: [
                    "Book round-trip flights",
                    "Reserve accommodation near city center",
                    "Create a shortlist of local restaurants",
                    "Plan a half-day hike",
                    "Buy local transit pass"
                ]
            )
        }
    }

    private func callOpenAI(goal: String, destination: String, budgetRange: String?, startDate: Date, endDate: Date, interests: [String]) async throws -> TripPlan {
        struct ChatRequest: Codable {
            struct Message: Codable { let role: String; let content: String }
            let model: String
            let messages: [Message]
            let temperature: Double
        }
        struct ChatResponse: Codable {
            struct Choice: Codable { struct Message: Codable { let content: String }; let message: Message }
            let choices: [Choice]
        }

        let prompt = """
        You are a proactive travel planner. Create a brief plan summary and 5-7 actionable tasks for a trip.
        Goal: \(goal)
        Destination: \(destination)
        Budget: \(budgetRange ?? "unspecified")
        Dates: \(startDate.description) to \(endDate.description)
        Interests: \(interests.joined(separator: ", "))

        Respond as JSON with fields: summary (string), suggestedTasks (array of strings).
        """

        let req = ChatRequest(
            model: "gpt-4o-mini",
            messages: [ .init(role: "system", content: "You are a helpful travel planning assistant."), .init(role: "user", content: prompt) ],
            temperature: 0.7
        )

        var request = URLRequest(url: URL(string: "https://api.openai.com/v1/chat/completions")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(ProcessInfo.processInfo.environment["OPENAI_API_KEY"] ?? "")", forHTTPHeaderField: "Authorization")
        request.httpBody = try JSONEncoder().encode(req)

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw NSError(domain: "AIService", code: 1, userInfo: [NSLocalizedDescriptionKey: "OpenAI API error"])
        }
        let chat = try JSONDecoder().decode(ChatResponse.self, from: data)
        let content = chat.choices.first?.message.content ?? "{}"

        if let jsonData = content.data(using: .utf8) {
            if let plan = try? JSONDecoder().decode(TripPlan.self, from: jsonData) {
                return plan
            }
        }
        // Fallback parse: split lines
        let lines = content.split(separator: "\n").map(String.init).filter { !$0.isEmpty }
        let tasks = Array(lines.prefix(6))
        return TripPlan(summary: "AI Trip Plan", suggestedTasks: tasks)
    }
}