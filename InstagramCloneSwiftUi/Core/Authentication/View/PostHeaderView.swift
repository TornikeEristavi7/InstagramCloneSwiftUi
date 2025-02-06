//
//  PostHeaderView.swift
//  InstagramCloneSwiftUi
//
//  Created by Tornike Eristavi on 06.02.25.
//

import SwiftUI

struct PostHeaderView: View {
    var body: some View {
        HStack {
            HStack {
                Image("person_2")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())

                Text("Mike Tyson")
                    .font(.caption)
                    .fontWeight(.bold)
            }
            Spacer()

            Image(systemName: "ellipsis")
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
    }
}

