//
//  ProfileView.swift
//  InstagramCloneSwiftUi
//
//  Created by Tornike Eristavi on 05.02.25.
//
import SwiftUI
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

struct MainView: View {
    @StateObject private var viewModel = FeedViewModel()
    @State private var scrollToTop: Bool = false
    @State private var scrollViewId: String = "scrollViewTop"
    
    var body: some View {
        NavigationStack {
            VStack {
                HeaderView(refreshAction: {
                    viewModel.loadPosts()
                    scrollToTop = true
                })
                
                ScrollViewReader { proxy in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            HomeStories()
                            Divider()
                            
                            ForEach(viewModel.posts) { post in
                                PostView(imageUrl: post.imageUrl, description: post.description)
                            }
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
                .environmentObject(viewModel)
            }
            .onAppear {
                viewModel.loadPosts()
            }
            .padding(.vertical, 12)
        }
    }
}
