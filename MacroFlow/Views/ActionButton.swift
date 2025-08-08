//
//  ActionButton.swift
//  MacroFlow
//
//  Created by Tristan Norbury on 8/8/2025.
//

import SwiftUI


struct ActionButton: View {
    let title: String
    let icon: String
    let action: () -> Void  

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                Text(title)
                    .font(.caption)
            }
            .padding(6)
        }
        .buttonStyle(.bordered)
        .controlSize(.small)
    }
}
