//
//  HeaderView.swift
//  InstagramCloneSwiftUi
//
//  Created by Tornike Eristavi on 06.02.25.
//

import SwiftUI

struct HeaderView: View {
    var refreshAction: () -> Void
    
    var body: some View {
        HStack {
            Text("Instagram")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            Button(action: {
                refreshAction()
            }) {
                Image(systemName: "arrow.clockwise") 
                    .font(.title)
            }
            .padding()
            .background(Circle().fill(Color.gray.opacity(0.2)))
        }
        .padding()
    }
}
