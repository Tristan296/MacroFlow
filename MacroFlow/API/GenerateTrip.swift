//
//  GenerateTrip.swift
//  MacroFlow
//
//  Created by Tristan Norbury on 8/8/2025.
//


import Foundation

func generateTrip(interests: String, startDate: Date, endDate: Date, completion: @escaping (Trip?) -> Void) {
    // Keep legacy shape but route through AIService for consistency
    Task {
        do {
            let plan = try await AIService.shared.generateTripPlan(
                goal: "Trip planning",
                destination: "",
                budgetRange: nil,
                startDate: startDate,
                endDate: endDate,
                interests: interests.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            )
            let trip = parseTripFrom(content: plan.summary, interests: interests, startDate: startDate, endDate: endDate)
            completion(trip)
        } catch {
            completion(nil)
        }
    }
}
