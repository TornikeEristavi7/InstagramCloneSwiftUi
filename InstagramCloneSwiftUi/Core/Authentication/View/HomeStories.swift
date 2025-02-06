//
//  HomeStories.swift
//  InstagramCloneSwiftUi
//
//  Created by Tornike Eristavi on 06.02.25.
//

import SwiftUI
import PhotosUI
import FirebaseStorage
import FirebaseAuth
import Firebase

struct HomeStories: View {
    @State private var isPickerPresented: Bool = false
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImageData: Data?
    @State private var isUploading = false
    @State private var uploadError: String?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                Button(action: {
                    isPickerPresented.toggle()
                }) {
                    VStack {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Circle()
                                        .stroke(
                                            LinearGradient(colors: [.blue, .purple, .red, .pink, .yellow, .orange], startPoint: .topLeading, endPoint: .bottomTrailing),
                                            lineWidth: 2.5
                                        )
                                )

                            Image(systemName: "plus")
                                .foregroundColor(.blue)
                                .font(.system(size: 24))
                        }
                    }
                    .frame(width: 60, height: 60)
                }
                .photosPicker(isPresented: $isPickerPresented, selection: $selectedItems, maxSelectionCount: 1, matching: .images)
                .onChange(of: selectedItems) { newItems in
                    if let item = newItems.first {
                        Task {
                            if let data = try? await item.loadTransferable(type: Data.self) {
                                selectedImageData = data
                                uploadImageToFirebaseStorage(imageData: data)
                            }
                        }
                    }
                }

                if let error = uploadError {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .padding()
                }

                if isUploading {
                    ProgressView("Uploading...")
                }

                StoryView(imageUrl: "https://randomuser.me/api/portraits/men/1.jpg", name: "John Smiller")
                StoryView(imageUrl: "https://randomuser.me/api/portraits/men/2.jpg", name: "Mike Tyson")
                StoryView(imageUrl: "https://randomuser.me/api/portraits/men/3.jpg", name: "Michael Smith")
                StoryView(imageUrl: "https://randomuser.me/api/portraits/men/4.jpg", name: "Jason Marrow")
                StoryView(imageUrl: "https://randomuser.me/api/portraits/women/1.jpg", name: "Anna Starrow")
                StoryView(imageUrl: "https://randomuser.me/api/portraits/men/5.jpg", name: "Jason Galaggher")
                StoryView(imageUrl: "https://randomuser.me/api/portraits/men/6.jpg", name: "Steeve Killow")
            }
            .padding(.horizontal, 8)
        }
    }

    func uploadImageToFirebaseStorage(imageData: Data) {
        guard let userId = Auth.auth().currentUser?.uid else {
            uploadError = "User is not authenticated"
            return
        }

        isUploading = true
        uploadError = nil
        
        let fileName = UUID().uuidString
        let storageRef = Storage.storage().reference().child("story_images/\(userId)/\(fileName).jpg")

        storageRef.putData(imageData, metadata: nil) { metadata, error in
            isUploading = false
            if let error = error {
                uploadError = "Error uploading image: \(error.localizedDescription)"
                print("Error uploading image: \(error.localizedDescription)")
            } else {
                print("Image uploaded successfully!")
                
                storageRef.downloadURL { url, error in
                    if let error = error {
                        uploadError = "Error getting download URL: \(error.localizedDescription)"
                        print("Error getting download URL: \(error.localizedDescription)")
                    } else if let url = url {
                        print("Image available at URL: \(url.absoluteString)")
                    }
                }
            }
        }
    }
}
