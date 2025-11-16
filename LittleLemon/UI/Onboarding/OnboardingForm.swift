//
//  OnboardingForm.swift
//  LittleLemon
//
//  Created by Laura Sales Martínez on 16/11/25.
//

import SwiftUI

struct OnboardingForm: View {
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var email: String

    var body: some View {
        VStack(spacing: 16) {
            LabeledInputField(
                title: "First Name *",
                text: $firstName
            )

            LabeledInputField(
                title: "Last Name *",
                text: $lastName
            )

            LabeledInputField(
                title: "Email *",
                text: $email,
                keyboardType: .emailAddress
            )
        }
        .padding(.horizontal)
    }
}
