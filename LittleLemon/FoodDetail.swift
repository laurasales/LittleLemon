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
        VStack(spacing: 12) {
            AsyncImage(url: URL(string: dish.image!)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 200, height: 200)
            Text(dish.title ?? "")
                .font(.title2)
            Text(dish.descript ?? "")
                .font(.callout)
            Text("Category: \(dish.category ?? "")")
                .font(.headline)
            Text("\(dish.price ?? "")€")
                .font(.title3)
        }
        .padding()
    }
}
