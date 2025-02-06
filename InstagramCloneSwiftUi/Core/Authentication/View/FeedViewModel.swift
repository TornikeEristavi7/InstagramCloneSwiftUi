//
//  FeedViewModel.swift
//  InstagramCloneSwiftUi
//
//  Created by Tornike Eristavi on 06.02.25.
//


import FirebaseFirestore
import SwiftUI

class FeedViewModel: ObservableObject {
    @Published var posts: [Post] = []

    func loadPosts() {
        let db = Firestore.firestore()
        db.collection("posts")
            .order(by: "timestamp", descending: true) 
            .getDocuments { snapshot, error in
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


struct Post: Identifiable, Codable {
    @DocumentID var id: String?
    var imageUrl: String
    var userId: String
    var description: String
    var timestamp: Timestamp
}
