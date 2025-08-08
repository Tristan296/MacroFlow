//
//  TripStatView.swift
//  MacroFlow
//
//  Created by Tristan Norbury on 8/8/2025.
//

import SwiftUICore


struct TripStatView: View {
    let label: String
    let value: Int
    let color: Color

    var body: some View {
        VStack {
            Text("\(value)")
                .font(.title3)
                .foregroundColor(color)
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}

