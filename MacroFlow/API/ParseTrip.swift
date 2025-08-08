//
//  ParseTrip.swift
//  MacroFlow
//
//  Created by Tristan Norbury on 8/8/2025.
//
import SwiftUI
import Foundation

func parseTripFrom(content: String, interests: String, startDate: Date, endDate: Date) -> Trip {
    // Very naive parsing — you should refine this using structured prompts or JSON output
    let title = content.components(separatedBy: "\n").first ?? "AI Trip"
    let destination = content.contains("to ") ? content.components(separatedBy: "to ").last?.components(separatedBy: "\n").first ?? "Unknown" : "Unknown"
    
    let trip = Trip(
        title: title,
        destination: destination,
        startDate: startDate,
        endDate: endDate,
        interests: interests.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) },
        progress: 0
    )

    // Optional: parse activities from response and add them as TripTask
    return trip
}
