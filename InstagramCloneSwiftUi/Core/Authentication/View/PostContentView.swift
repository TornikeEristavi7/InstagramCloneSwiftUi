//
//  PostContentView.swift
//  InstagramCloneSwiftUi
//
//  Created by Tornike Eristavi on 06.02.25.
//

import SwiftUI
import Kingfisher

struct PostContentView: View {
    var imageUrl: String

    var body: some View {
        VStack {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFit()
                .frame(width: .infinity, height: 400)
                .clipped()
        }
    }
}

