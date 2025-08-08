//
//  NewTrip.swift
//  MacroFlow
//
//  Created by Tristan Norbury on 8/8/2025.
//

import SwiftUI

struct CreateTripView: View {
    @State private var destination: String = ""
    @State private var budgetRange: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State var interests: String = ""
    @State private var tripGoal = ""

    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("🧠 AI-Powered Trip Planning")
                        .font(.title2)
                        .bold()

                    // Trip Goal
                    VStack(alignment: .leading) {
                        Text("Describe your travel goal *")
                        TextEditor(text: $tripGoal)
                            .frame(height: 100)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.4)))
                            .padding(.top, 4)
                    }

                    // Destination
                    TextField("Destination", text: $destination)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    // Budget
                    TextField("Budget Range (e.g. $3000 - $5000)", text: $budgetRange)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    // Dates
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    DatePicker("End Date", selection: $endDate, displayedComponents: .date)

                    // Interests
                    TextField("Interests (comma-separated)", text: $interests)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    // Generate Trip Button
                    Button(action: generateTrip) {
                        HStack {
                            Image(systemName: "sparkles")
                            Text("Generate Trip Plan")
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    
                    Text("💡 Tip: Be specific in your goal description for better AI suggestions.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                }
                .padding()
            }
            .navigationTitle("Create New Trip")
            .navigationBarItems(leading: Button("Cancel", action: {}))
        }
    }

    func generateTrip() {
        // Call backend AI trip planner (OpenAI / HuggingFace)
        // Pass: tripGoal, destination, budgetRange, startDate, endDate, interests
        // Result: list of macro tasks and subtasks
    }

}
