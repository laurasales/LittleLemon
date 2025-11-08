//
//  UserProfile.swift
//  LittleLemon
//
//  Created by Laura Sales Martínez on 8/11/25.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation
    
    private let firstName: String = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    private let lastName: String = UserDefaults.standard.string(forKey: kLastName) ?? ""
    private let email: String = UserDefaults.standard.string(forKey: kEmail) ?? ""
    
    var body: some View {
        VStack {
            Text("Personal information")
            Image("profile-image-placeholder")
            Text(firstName)
            Text(lastName)
            Text(email)
            Spacer()
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
}

#Preview {
    UserProfile()
}
