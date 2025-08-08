//
//  TripSectionView.swift
//  MacroFlow
//
//  Created by Tristan Norbury on 8/8/2025.
//

import SwiftUI


struct TripSectionView: View {
    var sectionTitle: String
    var progress: Double

    private let actionItems: [ActionItem] = [
        ActionItem(type: .regenerate),
        ActionItem(type: .suggest),
        ActionItem(type: .searchAndBook),
        ActionItem(type: .addSubTask)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(sectionTitle)
                    .font(.headline)
                Spacer()
                Text("\(Int(progress))%")
            }

            ProgressView(value: progress / 100)
                .tint(.purple)

            HStack(spacing: 12) {
                ForEach(actionItems) { item in
                    ActionButton(title: item.type.title, icon: item.type.icon) {
                        handleAction(item.type)
                    }
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }

    // 🎯 Add the handler method here
    private func handleAction(_ action: TripActionType) {
        switch action {
        case .regenerate:
            print("Regenerate AI action triggered.")
        case .suggest:
            print("AI Suggestions action triggered.")
        case .searchAndBook:
            print("Search & Book action triggered.")
        case .addSubTask:
            print("Add Subtask action triggered.")
        }
    }
}

#Preview {
    TripSectionView(sectionTitle: "Trip to sydney", progress: 75)
}
