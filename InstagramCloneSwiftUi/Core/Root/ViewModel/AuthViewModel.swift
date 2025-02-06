//
//  AuthViewModel.swift
//  InstagramCloneSwiftUi
//
//  Created by Tornike Eristavi on 05.02.25.
//


import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }

    func registerUser(email: String, fullname: String, password: String) async throws {
        do {

            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            

            let userData = ["uid": result.user.uid, "email": email, "fullname": fullname]
            try await Firestore.firestore().collection("users").document(result.user.uid).setData(userData)
            
            print("DEBUG: Successfully registered user and saved to Firestore")
        } catch {
            print("DEBUG: Failed to register with error \(error.localizedDescription)")
        }
    }

    func signInUser(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            print("DEBUG: Successfully signed in")
        } catch {
            print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
        }
    }

    func signOutUser() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
}
