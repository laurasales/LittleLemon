//
//  Onboarding.swift
//  LittleLemon
//
//  Created by Laura Sales Martínez on 4/11/25.
//

import SwiftUI

struct Onboarding: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var isLoggedIn: Bool = false
    
    @State private var showValidationError: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                
                VStack(spacing: 8) {
                    Text("Welcome to ")
                        .font(.largeTitle)
                        .bold()
                    + Text("Little Lemon")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.accentColor)
                    
                    Text("Create your account to continue")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 60)
                .padding(.horizontal)
                
                VStack(spacing: 16) {
                    CustomTextField(placeholder: "First Name", text: $firstName)
                    CustomTextField(placeholder: "Last Name", text: $lastName)
                    CustomTextField(placeholder: "Email", text: $email, keyboardType: .emailAddress)
                }
                .padding(.horizontal)
                
                if showValidationError {
                    Text("Please enter valid information in all fields.")
                        .foregroundColor(.red)
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                }
                
                Button(action: register) {
                    Text("Register")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: isValidForm() ? 3 : 0)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .onAppear {
                let loggedIn = UserDefaults.standard.bool(forKey: kIsLoggedIn)
                isLoggedIn = loggedIn

                if !loggedIn {
                    firstName = ""
                    lastName = ""
                    email = ""
                }
            }
            .navigationDestination(isPresented: $isLoggedIn) { Home() }
        }
    }
    
    private func register() {
        if isValidForm() {
            UserDefaults.standard.set(firstName, forKey: kFirstName)
            UserDefaults.standard.set(lastName, forKey: kLastName)
            UserDefaults.standard.set(email, forKey: kEmail)
            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
            isLoggedIn = true
        } else {
            showValidationError = true
        }
    }
    
    private func isValidForm() -> Bool {
        return isValid(name: firstName) && isValid(name: lastName) && isValid(email: email)
    }
    
    private func isValid(name: String) -> Bool {
        guard !name.isEmpty, name.count > 2 else { return false }
        for chr in name {
            if !(chr.isLetter || chr == " ") { return false }
        }
        return true
    }
    
    private func isValid(email:String) -> Bool {
        guard !email.isEmpty else { return false }
        let regex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
}

#Preview {
    Onboarding()
}
