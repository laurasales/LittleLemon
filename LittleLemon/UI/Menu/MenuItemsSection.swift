//
//  MenuItemsSection.swift
//  LittleLemon
//
//  Created by Laura Sales Martínez on 16/11/25.
//

import SwiftUI

struct MenuItemsSection: View {
    var predicate: NSPredicate
    var sort: [NSSortDescriptor]
    
    var body: some View {
        FetchedObjects(
            predicate: predicate,
            sortDescriptors: sort
        ) { (dishes: [Dish]) in
            List(dishes) { dish in
                NavigationLink(destination: FoodDetail(dish: dish)) {
                    FoodItem(dish: dish)
                        .padding(.vertical, 8)
                }
                .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
        }
    }
}
