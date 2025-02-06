//
//  UploadPhotoView.swift
//  InstagramCloneSwiftUi
//
//  Created by Tornike Eristavi on 05.02.25.
//
import SwiftUI
import Kingfisher

struct StoryView: View {
    let imageUrl: String
    let name: String
    
    var body: some View {
        VStack {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            
            Text(name)  
                .font(.caption)
                .foregroundColor(.primary)
        }
    }
}
