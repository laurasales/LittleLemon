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
        NavigationView {
            VStack(spacing: 30) {
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
                
                VStack(spacing: 15) {
                    UserInfoRow(title: "First Name", value: firstName)
                    UserInfoRow(title: "Last Name", value: lastName)
                    UserInfoRow(title: "Email", value: email)
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    logout()
                }) {
                    Text("Logout")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 3)
                }
                .padding()
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
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
