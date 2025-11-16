//
//  CategoryItem.swift
//  LittleLemon
//
//  Created by Laura Sales Martínez on 16/11/25.
//

import SwiftUI

struct CategoryItem: View {
    let title: String
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Text(title.capitalized)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(
                ZStack {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.primaryGreen)
                            .shadow(radius: 3)
                    } else {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.primaryGreen.opacity(0.2))
                    }
                }
            )
            .foregroundColor(isSelected ? .white : .primaryGreen)
            .bold()
            .onTapGesture {
                withAnimation(.spring()) {
                    onTap()
                }
            }
    }
}
