//
//  TripTask.swift
//  MacroFlow
//
//  Created by Tristan Norbury on 8/8/2025.
//


import Foundation

struct TripTask: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    var dueDate: Date
    var priority: String
    var isCompleted: Bool

    init(
        id: UUID = UUID(),
        title: String,
        dueDate: Date,
        priority: String = "High",
        isCompleted: Bool = false
    ) {
        self.id = id
        self.title = title
        self.dueDate = dueDate
        self.priority = priority
        self.isCompleted = isCompleted
    }
}
