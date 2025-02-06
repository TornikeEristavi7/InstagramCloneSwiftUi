//
//  AddStoryView.swift
//  InstagramCloneSwiftUi
//
//  Created by Tornike Eristavi on 06.02.25.
//
import SwiftUI
import PhotosUI
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

struct AddStoryView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var isUploading = false
    @State private var uploadError: String?
    @State private var description: String = ""

    @Binding var selectedPostImage: UIImage?
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    PhotosPicker("Pick a Story Image", selection: $selectedItem, matching: .images)
                        .onChange(of: selectedItem) { newItem in
                            Task {
                                if let item = newItem, let data = try? await item.loadTransferable(type: Data.self) {
                                    selectedImageData = data
                                    if let uiImage = UIImage(data: data) {
                                        selectedPostImage = uiImage
                                    }
                                }
                            }
                        }

                    if let imageData = selectedImageData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: 300)
                            .clipped()
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }

                    TextField("Enter description", text: $description)
                        .padding(10)
                        .frame(height: 40) 
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .layoutPriority(1)

                    if let error = uploadError {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                            .padding(.top)
                    }

                    Button("Upload to Firebase") {
                        if let imageData = selectedImageData {
                            uploadImageToFirebaseStorage(imageData: imageData)
                        }
                    }
                    .disabled(isUploading || selectedImageData == nil)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                }

                if isUploading {
                    Color.black.opacity(0.3)
                        .edgesIgnoringSafeArea(.all)
                    ProgressView("Uploading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                        .background(Color.white.opacity(0.8), in: RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(.top)
            .navigationTitle("Add Story")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
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
        let storageRef = Storage.storage().reference().child("posts/\(userId)/\(fileName).jpg")

        storageRef.putData(imageData, metadata: nil) { metadata, error in
            isUploading = false
            if let error = error {
                uploadError = "Error uploading image: \(error.localizedDescription)"
            } else {
                storageRef.downloadURL { url, error in
                    if let error = error {
                        uploadError = "Error getting download URL: \(error.localizedDescription)"
                    } else if let url = url {
                        savePostToFirestore(imageUrl: url.absoluteString, userId: userId)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }

    func savePostToFirestore(imageUrl: String, userId: String) {
        let db = Firestore.firestore()
        let newPostDoc = db.collection("posts").document()

        let postData: [String: Any] = [
            "imageUrl": imageUrl,
            "userId": userId,
            "description": description,
            "timestamp": Timestamp()
        ]

        newPostDoc.setData(postData) { error in
            if let error = error {
                print("Error saving post: \(error.localizedDescription)")
            } else {
                print("Post saved successfully!")
            }
        }
    }
}
