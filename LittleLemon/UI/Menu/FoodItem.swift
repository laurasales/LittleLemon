//
//  FoodItem.swift
//  LittleLemon
//
//  Created by Laura Sales Martínez on 10/11/25.
//

import SwiftUI

struct FoodItem: View {
    let dish: Dish
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: dish.image ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 70, height: 70)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .cornerRadius(12)
                case .failure(_):
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(dish.title ?? "")
                    .font(.headline)
                Text(dish.descript ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                Text("\(dish.price ?? "0")€")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.primaryGreen)
            }
            Spacer()
        }
        .padding(8)
        .background(Color.white.opacity(0.9))
        .cornerRadius(12)
        //.shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}
