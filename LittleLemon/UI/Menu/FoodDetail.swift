//
//  FoodDetail.swift
//  LittleLemon
//
//  Created by Laura Sales Martínez on 10/11/25.
//

import SwiftUI

struct FoodDetail: View {
    let dish: Dish
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: dish.image!)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                        .frame(width: 250, height: 250)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(20)
                }
                .frame(width: 200, height: 200)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(dish.title ?? "")
                        .font(.title)
                        .bold()
                    
                    Text(dish.descript ?? "")
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        CategoryItem(
                            title: dish.category ?? "",
                            isSelected: false
                        ) {}
                        
                        Spacer()
                        
                        Text("\(dish.price ?? "0") €")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.primaryGreen)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle(dish.title ?? "Dish")
        .navigationBarTitleDisplayMode(.inline)
    }
}
