//
//  PostView.swift
//  InstagramCloneSwiftUi
//
//  Created by Tornike Eristavi on 06.02.25.
//

import SwiftUI
import Kingfisher

struct PostView: View {
    let imageUrl: String
    let description: String

    @State private var isLiked = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 400)
                .clipShape(Rectangle())
                .clipped()
                .overlay(
                    VStack {
                        Spacer()
                        HStack {
                            Text(description)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.white)
                                .padding(8)
                                .background(Color.black.opacity(0.6))
                                .cornerRadius(8)
                            Spacer()
                        }
                        .padding(.bottom, 8)
                        .padding(.leading, 8)
                    }
                )

            HStack {
                Button(action: {
                    isLiked.toggle()
                }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .font(.system(size: 24))
                        .foregroundColor(isLiked ? .red : .black)
                }

                Button(action: {
                }) {
                    Image(systemName: "bubble.right")
                        .font(.system(size: 22))
                        .foregroundColor(.black)
                }

                Button(action: {
                }) {
                    Image(systemName: "paperplane")
                        .font(.system(size: 22))
                        .foregroundColor(.black)
                }

                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
        }
    }
}
