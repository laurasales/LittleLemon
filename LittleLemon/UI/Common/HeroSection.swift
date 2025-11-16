//
//  HeroSection.swift
//  LittleLemon
//
//  Created by Laura Sales Martínez on 16/11/25.
//

import SwiftUI

struct HeroSection: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Little Lemon")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.accent)

                    Text("Chicago")
                        .font(.title)
                        .foregroundColor(.white)
                }

                Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                    .font(.body)
                    .foregroundColor(.white)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()

            Image("hero")
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding()
        .background(.primaryGreen)
    }
}
