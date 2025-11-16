//
//  Logo.swift
//  LittleLemon
//
//  Created by Laura Sales Martínez on 16/11/25.
//

import SwiftUI

struct Logo: View {
    var body: some View {
        Image("logo")
            .resizable()
            .scaledToFit()
            .frame(height: 40)
            .padding(.top, 20)
    }
}
