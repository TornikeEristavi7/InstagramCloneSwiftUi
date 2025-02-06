//
//  InputView.swift
//  InstagramCloneSwiftUi
//
//  Created by Tornike Eristavi on 05.02.25.
//


import SwiftUI

struct InputView: View {
    @Binding var text: String
    var Title: String
    var placeholder: String
    var isSecureField: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(Title)
                .font(.caption)
                .foregroundColor(.gray)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            } else {
                TextField(placeholder, text: $text)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
        }
    }
}
