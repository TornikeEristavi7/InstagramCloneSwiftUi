//
//  RegistrationView.swift
//  InstagramCloneSwiftUi
//
//  Created by Tornike Eristavi on 05.02.25.
//
import SwiftUI
import FirebaseAuth

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage: String? = nil
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Image("InstagramLogo")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 120)
                .padding(.vertical, 32)
            
            VStack(spacing: 24) {
                InputView(text: $email,
                          Title: "Email Address",
                          placeholder: "name@example.com")
                    .autocapitalization(.none)
                
                InputView(text: $fullname,
                          Title: "Full Name",
                          placeholder: "Enter your name")
                
                InputView(text: $password,
                          Title: "Password",
                          placeholder: "Enter your password",
                          isSecureField: true)
                    .keyboardType(.default)
                    .textContentType(.oneTimeCode) // Prevents strong password suggestion

                InputView(text: $confirmPassword,
                          Title: "Confirm Password",
                          placeholder: "Confirm your password",
                          isSecureField: true)
                    .keyboardType(.default)
                    .textContentType(.oneTimeCode) // Prevents strong password suggestion
 // Ensures correct keyboard behavior

            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.top, 8)
            }
            
            Button {
                Task {
                    await signUp()
                }
            } label: {
                HStack {
                    Text("SIGN UP")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.systemBlue))
                .cornerRadius(10)
                .padding(.top, 24)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    Text("Sign in")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
            .padding(.top, 12)
        }
        .padding(.horizontal)
    }

    private func signUp() async {
        guard password == confirmPassword else {
            errorMessage = "Passwords don't match!"
            return
        }
        
        do {
            let _ = try await Auth.auth().createUser(withEmail: email, password: password)
            // After signup, navigate to LoginView
            dismiss() // Dismiss the RegistrationView and return to LoginView
        } catch {
            errorMessage = "Failed to create account: \(error.localizedDescription)"
        }
    }
}
