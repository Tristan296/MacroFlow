//
//  ParseTrip.swift
//  MacroFlow
//
//  Created by Tristan Norbury on 8/8/2025.
//
import SwiftUI
import Foundation

func parseTripFrom(content: String, interests: String, startDate: Date, endDate: Date) -> Trip {
    // Naive parsing to pull a destination and a title-like line
    let firstLine = content.components(separatedBy: "\n").first?.trimmingCharacters(in: .whitespacesAndNewlines)
    let extractedTitle = firstLine?.isEmpty == false ? firstLine! : "AI Trip"

    var extractedDestination = "Unknown"
    if let range = content.range(of: "to ") {
        let after = content[range.upperBound...]
        if let line = after.components(separatedBy: "\n").first {
            extractedDestination = line.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }

    let dateRange = DateInterval(start: startDate, end: endDate)
    let tags = interests
        .components(separatedBy: ",")
        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        .filter { !$0.isEmpty }

    let trip = Trip(
        destination: extractedDestination,
        tripDescription: extractedTitle,
        tags: tags,
        location: extractedDestination,
        dateRange: dateRange,
        progress: 0.0
    )
    return trip
}
