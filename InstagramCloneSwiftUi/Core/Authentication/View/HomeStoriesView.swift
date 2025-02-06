//
//  HomeStoriesView.swift
//  InstagramCloneSwiftUi
//
//  Created by Tornike Eristavi on 06.02.25.
//


import SwiftUI

struct HomeStoriesView: View {
    @StateObject private var viewModel = StoryViewModel()

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.stories) { story in
                    StoryView(imageUrl: story.imageUrl, name: story.name) 
                }
            }
            .padding()
        }
    }
}
