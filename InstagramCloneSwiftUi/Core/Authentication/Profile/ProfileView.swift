//
//  ProfileView.swift
//  InstagramCloneSwiftUi
//
//  Created by Tornike Eristavi on 06.02.25.
//

import SwiftUI
import Kingfisher
import FirebaseAuth

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    let columns = [
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1)
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HStack {
                    KFImage(URL(string: "https://randomuser.me/api/portraits/men/1.jpg"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding(.leading, 20)

                    VStack(alignment: .leading) {
                        Text("john_doe")
                            .font(.system(size: 22, weight: .bold))
                        Text("John Doe")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)

                        HStack {
                            Button(action: {}) {
                                Text("Follow")
                                    .fontWeight(.bold)
                                    .foregroundColor(.blue)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 16)
                                    .background(Capsule().strokeBorder(Color.blue))
                            }
                            
                            Button(action: {}) {
                                Text("Edit Profile")
                                    .fontWeight(.bold)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 16)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(12)
                            }
                        }
                    }
                    .padding(.leading, 16)

                    Spacer()
                }
                .padding(.top, 20)

                Divider()

                HStack {
                    VStack {
                        Text("\(viewModel.posts.count)")
                            .font(.system(size: 22, weight: .bold))
                        Text("Posts")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    VStack {
                        Text("2.3K")
                            .font(.system(size: 22, weight: .bold))
                        Text("Followers")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    VStack {
                        Text("1K")
                            .font(.system(size: 22, weight: .bold))
                        Text("Following")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)

                Divider()

                VStack(alignment: .leading) {
                    Text("Hey! I'm John Doe, just a regular guy sharing his life with the world. Let's connect and share good vibes!")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .padding(.horizontal, 20)
                        .padding(.top, 8)
                }

                Divider()

                LazyVGrid(columns: columns, spacing: 1) {
                    ForEach(viewModel.posts) { post in
                        KFImage(URL(string: post.imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width / 3 - 1, height: UIScreen.main.bounds.width / 3 - 1)
                            .clipShape(Rectangle())
                            .clipped()
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadUserPosts()
        }
        .navigationTitle("Profile")
    }
}
