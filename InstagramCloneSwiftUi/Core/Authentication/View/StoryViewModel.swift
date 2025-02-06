//
//  StoryViewModel.swift
//  InstagramCloneSwiftUi
//
//  Created by Tornike Eristavi on 06.02.25.
//

import FirebaseFirestore

struct Story: Identifiable {
    var id: String
    var imageUrl: String
    var name: String
}

class StoryViewModel: ObservableObject {
    @Published var stories: [Story] = []
    
    private var db = Firestore.firestore()
    
    init() {
        fetchStories()
    }
    
    func fetchStories() {
        db.collection("stories")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error fetching stories: \(error.localizedDescription)")
                    return
                }
                
                if let snapshot = snapshot {
                    self.stories = snapshot.documents.compactMap { doc in
                        if let imageUrl = doc["imageUrl"] as? String,
                           let name = doc["name"] as? String {
                            return Story(id: doc.documentID, imageUrl: imageUrl, name: name)
                        }
                        return nil
                    }
                }
            }
    }
}
