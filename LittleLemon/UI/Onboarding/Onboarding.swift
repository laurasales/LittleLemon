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
            VStack(spacing: 24) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                    .padding(.top, 20)
                
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
                        .background(.primaryGreen)
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
