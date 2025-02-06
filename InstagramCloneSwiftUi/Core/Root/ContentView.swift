//
//  ContentView.swift
//  InstagramCloneSwiftUi
//
//  Created by Tornike Eristavi on 05.02.25.

import SwiftUI

struct ContentView: View {
    @State private var scrollToTopAction: () -> Void = {
        
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                TabBarView(scrollToTopAction: scrollToTopAction)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

