//
//  ProfileViewModel.swift
//  InstagramCloneSwiftUi
//
//  Created by Tornike Eristavi on 06.02.25.
//

import FirebaseFirestore
import FirebaseAuth
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var posts: [Post] = []

    func loadUserPosts() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("No authenticated user found")
            return
        }

        let db = Firestore.firestore()
        db.collection("posts")
            .whereField("userId", isEqualTo: userId)
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error loading posts: \(error.localizedDescription)")
                } else {
                    self.posts = snapshot?.documents.compactMap { doc in
                        try? doc.data(as: Post.self)
                    } ?? []
                }
            }
    }
}
