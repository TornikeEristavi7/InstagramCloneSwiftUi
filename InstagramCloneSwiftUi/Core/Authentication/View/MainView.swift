//
//  ProfileView.swift
//  InstagramCloneSwiftUi
//
//  Created by Tornike Eristavi on 05.02.25.
//
import SwiftUI
import Kingfisher
import PhotosUI

struct MainView: View {
    @State private var scrollToTop: Bool = false
    @State private var scrollViewId: String = "scrollViewTop"

    var body: some View {
        NavigationStack {
            VStack {
                HeaderView()

                ScrollViewReader { proxy in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            HomeStories()
                            Divider()
                            PostView(imageName: "post_1", description: "Such an amazing day! Life is beautiful when you're surrounded by good vibes and great company. 🌟")
                            PostView(imageName: "post_2", description: "Chasing sunsets and making memories. Grateful for the simple moments that matter the most. 🌅💫")
                            PostView(imageName: "post_3", description: "Happiness is best shared with friends. Moments like these remind me why life is so special. 💕✨")
                            PostView(imageName: "post_4", description: "Smiles are contagious, and I'm all for spreading the joy. Here's to many more happy moments! 😁💖")
                        }
                        .id(scrollViewId)
                        .onChange(of: scrollToTop) { _ in
                            if scrollToTop {
                                withAnimation {
                                    proxy.scrollTo(scrollViewId, anchor: .top)
                                }
                                scrollToTop = false
                            }
                        }
                    }
                }

                TabBarView(scrollToTopAction: {
                    scrollToTop = true
                })
            }
            .padding(.vertical, 12)
        }
    }
}











