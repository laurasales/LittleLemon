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
        HStack {
            Text("\(dish.title!), \(dish.price!)€")
            AsyncImage(url: URL(string: dish.image!)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
        }
    }
}
