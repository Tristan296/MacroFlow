//
//  GenerateTrip.swift
//  MacroFlow
//
//  Created by Tristan Norbury on 8/8/2025.
//


import Foundation

func generateTrip(interests: String, startDate: Date, endDate: Date, completion: @escaping (Trip?) -> Void) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"

    let prompt = """
    Plan a fun trip between \(formatter.string(from: startDate)) and \(formatter.string(from: endDate)). The user's interests are: \(interests). Suggest a destination, a title for the trip, and a list of 3-5 activities (each with a title and date).
    """

    let apiKey = "YOUR_OPENAI_API_KEY"
    let url = URL(string: "https://api.openai.com/v1/chat/completions")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let requestBody: [String: Any] = [
        "model": "gpt-4",
        "messages": [
            ["role": "system", "content": "You are a travel planner AI."],
            ["role": "user", "content": prompt]
        ],
        "temperature": 0.8
    ]

    request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)

    URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data,
              let result = try? JSONDecoder().decode(OpenAIResponse.self, from: data),
              let content = result.choices.first?.message.content else {
            print("AI error:", error ?? NSError())
            completion(nil)
            return
        }

        let trip = parseTripFrom(content: content, interests: interests, startDate: startDate, endDate: endDate)
        completion(trip)
    }.resume()
}
