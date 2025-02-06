//
//  SearchView.swift
//  InstagramCloneSwiftUi
//
//  Created by Tornike Eristavi on 06.02.25.
//

import SwiftUI

struct SearchView: View {
    @State private var searchQuery: String = ""
    
    let people = [
        ("John Smiller", "https://www.w3schools.com/w3images/avatar2.png"),
        ("Mike Tyson", "https://www.w3schools.com/w3images/avatar2.png"),
        ("Michael Smith", "https://www.w3schools.com/w3images/avatar2.png"),
        ("Jason Marrow", "https://www.w3schools.com/w3images/avatar2.png"),
        ("Anna Starrow", "https://www.w3schools.com/w3images/avatar2.png"),
        ("Jason Galaggher", "https://www.w3schools.com/w3images/avatar2.png"),
        ("Steeve Killow", "https://www.w3schools.com/w3images/avatar2.png")
    ]
    
    var filteredPeople: [(String, String)] {
        if searchQuery.isEmpty {
            return people
        } else {
            return people.filter { $0.0.lowercased().contains(searchQuery.lowercased()) }
        }
    }
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(people, id: \.0) { person in
                        VStack {
                            AsyncImage(url: URL(string: person.1)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle().stroke(Color.blue, lineWidth: 2)
                                    )
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 60, height: 60)
                            }
                            
                            Text(person.0)
                                .font(.caption)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                        }
                        .frame(width: 80)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)
            }
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search", text: $searchQuery)
                    .padding(10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .font(.system(size: 16))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .padding(.horizontal, 16)
            .padding(.top, 20)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 5) 
            
            List(filteredPeople, id: \.0) { person in
                HStack {
                    AsyncImage(url: URL(string: person.1)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .padding(.trailing, 10)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 40, height: 40)
                    }
                    
                    Text(person.0)
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                    
                    Spacer()
                }
                .padding(.vertical, 8)
            }
            .listStyle(PlainListStyle())
        }
        .navigationBarTitle("Search", displayMode: .inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}


