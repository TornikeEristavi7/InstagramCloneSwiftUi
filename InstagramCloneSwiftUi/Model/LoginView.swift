//
//  LoginView.swift
//  InstagramCloneSwiftUi
//
//  Created by Tornike Eristavi on 05.02.25.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String? = nil
    @State private var isLoggingIn = false
    @State private var isAuthenticated = false
    
    var body: some View {
        NavigationView {
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
                    
                    InputView(text: $password,
                              Title: "Password",
                              placeholder: "Enter your password",
                              isSecureField: true)
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
                        await logIn()
                    }
                } label: {
                    HStack {
                        Text("LOG IN")
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
                
                NavigationLink(destination: RegistrationView()) {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
                .padding(.top, 12)
                

                NavigationLink(destination: MainView(), isActive: $isAuthenticated) {
                    EmptyView()
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func logIn() async {
        do {
            let _ = try await Auth.auth().signIn(withEmail: email, password: password)

            isAuthenticated = true
        } catch {
            errorMessage = "Incorrect email or password. Please try again."
        }
    }
}
