//
//  UserProfile.swift
//  LittleLemon
//
//  Created by Laura Sales Martínez on 8/11/25.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation
    
    @State private var firstName: String = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    @State private var lastName: String = UserDefaults.standard.string(forKey: kLastName) ?? ""
    @State private var email: String = UserDefaults.standard.string(forKey: kEmail) ?? ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                VStack(spacing: 12) {
                    Text("Personal Information")
                        .font(.title)
                        .bold()
                    
                    Image("profile-image-placeholder")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
                .padding(.top, 40)
                
                ProfileForm(firstName: $firstName, lastName: $lastName, email: $email)
                
                Spacer()
                
                FilledButton(title: "Log out", shadowRadius: 3, onClick: logout)
                    .padding()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Logo()
                }
            }
        }
    }
    
    private func logout() {
        UserDefaults.standard.set(false, forKey: kIsLoggedIn)
        presentation.wrappedValue.dismiss()
    }
}

#Preview {
    UserProfile()
}
