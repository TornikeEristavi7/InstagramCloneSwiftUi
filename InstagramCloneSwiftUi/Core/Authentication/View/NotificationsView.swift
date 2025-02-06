//
//  NotificationsView.swift
//  InstagramCloneSwiftUi
//
//  Created by Tornike Eristavi on 06.02.25.
//

import SwiftUI

struct NotificationsView: View {
    let names = ["Anna Starrow", "Mike Tyson", "John Smiller", "Steeve Killow", "Jason Marrow"]
    let actions = ["liked your post", "commented: 'Great shot!'", "started following you", "liked your photo", "commented: 'Looks amazing!'"]
    
    var body: some View {
        VStack {
            Text("Notifications")
                .font(.title)
                .padding()

            List {
                ForEach(0..<10, id: \.self) { _ in
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.gray)
                        
                        VStack(alignment: .leading) {
                            Text(names.randomElement() ?? "User")
                                .fontWeight(.bold)
                            Text(actions.randomElement() ?? "Action")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        if actions.randomElement() == "liked your post" || actions.randomElement() == "liked your photo" {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                        } else if actions.randomElement() == "commented: 'Great shot!'" || actions.randomElement() == "commented: 'Looks amazing!'" {
                            Image(systemName: "message.fill")
                                .foregroundColor(.blue)
                        } else {
                            Image(systemName: "person.fill.checkmark")
                                .foregroundColor(.green)
                        }
                    }
                }
            }
        }
    }
}
