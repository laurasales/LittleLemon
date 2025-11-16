//
//  CategoriesSection.swift
//  LittleLemon
//
//  Created by Laura Sales Martínez on 16/11/25.
//

import SwiftUI

struct CategoriesSection: View {
    let categories: [String]
    @Binding var selectedCategory: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Order for delivery!")
                .textCase(.uppercase)
                .font(.headline)
                .fontWeight(.heavy)
                .padding(.horizontal)
                .padding(.vertical, 4)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(categories, id: \.self) { category in
                        CategoryItem(
                            title: category,
                            isSelected: selectedCategory == category
                        ) {
                            selectedCategory = (selectedCategory == category) ? nil : category
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
