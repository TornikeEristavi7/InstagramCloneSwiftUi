
//  InstagramCloneSwiftUiApp.swift
//  InstagramCloneSwiftUi
//
//  Created by Tornike Eristavi on 05.02.25.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage
import Kingfisher
@main
struct InstagramCloneSwiftUiApp: App {
    @StateObject var authViewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure() 
    }
    
    var body: some Scene {
        WindowGroup {
           
            MainView()
        }
    }
}

