//
//  MenuItem.swift
//  LittleLemon
//
//  Created by Laura Sales Martínez on 4/11/25.
//

import Foundation

struct MenuItem: Decodable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let price: String
    let image: String
    let category: String
}
