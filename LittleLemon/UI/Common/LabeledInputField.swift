//
//  LabeledInputField.swift
//  LittleLemon
//
//  Created by Laura Sales Martínez on 16/11/25.
//

import SwiftUI

struct LabeledInputField: View {
    var title: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)

            TextField(title, text: $text)
                .padding()
                .keyboardType(keyboardType)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
        }
    }
}
