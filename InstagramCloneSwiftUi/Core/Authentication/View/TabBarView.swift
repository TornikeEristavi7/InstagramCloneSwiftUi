//
//  TabBarView.swift
//  InstagramCloneSwiftUi
//
//  Created by Tornike Eristavi on 06.02.25.
//
import SwiftUI
import Kingfisher
import PhotosUI
import FirebaseStorage

struct TabBarView: View {
    @State private var selectedPostImage: UIImage?
    @State private var showAddStoryView = false
    var scrollToTopAction: () -> Void

    @State private var showSearchView = false
    @State private var showNotificationsView = false

    var body: some View {
        VStack(spacing: 0) {
            Divider()

            HStack {
                Button(action: {
                    scrollToTopAction()
                }) {
                    Image(systemName: "house")
                        .frame(width: 28, height: 28)
                        .foregroundColor(.blue)
                }

                Spacer()

                Button(action: {
                    showSearchView.toggle()
                }) {
                    Image(systemName: "magnifyingglass")
                        .frame(width: 28, height: 28)
                        .foregroundColor(.blue)
                }
                .sheet(isPresented: $showSearchView) {
                    SearchView()
                }

                Spacer()

                Button(action: {
                    showAddStoryView.toggle()
                }) {
                    Image(systemName: "plus")
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
                .fullScreenCover(isPresented: $showAddStoryView) {
                    AddStoryView(selectedPostImage: $selectedPostImage)
                }

                Spacer()

                // profile gilakistvis
                NavigationLink(destination: ProfileView()) {
                    Image(systemName: "person.fill")
                        .frame(width: 28, height: 28)
                        .foregroundColor(.blue)
                }
                
                Spacer()

                Button(action: {
                    showNotificationsView.toggle()
                }) {
                    Image(systemName: "bell")
                        .frame(width: 28, height: 28)
                        .foregroundColor(.blue)
                }
                .sheet(isPresented: $showNotificationsView) {
                    NotificationsView()
                }
            }
            .font(.system(size: 20))
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
        }
    }
}
//s
