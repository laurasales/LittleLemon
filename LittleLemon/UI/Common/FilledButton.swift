//
//  FilledButton.swift
//  LittleLemon
//
//  Created by Laura Sales Martínez on 16/11/25.
//

import SwiftUI

struct FilledButton: View {
    var title: String
    var shadowRadius: CGFloat
    var onClick: () -> Void

    var body: some View {
        Button(action: onClick) {
            Text(title)
                .bold()
                .frame(maxWidth: .infinity)
                .padding()
                .background(.primaryGreen)
                .foregroundColor(.white)
                .cornerRadius(12)
                .shadow(radius: shadowRadius)
        }
    }
}
