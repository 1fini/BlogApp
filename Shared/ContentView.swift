//
//  ContentView.swift
//  Shared
//
//  Created by Dan on 14/01/2022.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @State private var results = [Post]()
    @StateObject var store = BlogPostsStore()
    
    var body: some View {
        VStack {
            Text("Parents Impliqués")
        }
        .foregroundColor(.primary)
        .font(.title)
        .shadow(color: Color.gray, radius: 2, x: 1, y: 1)
        TabView {
            MainView()
                .environmentObject(store)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Accueil")
                }
            AllPosts()
                .environmentObject(store)
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Articles")
                }
        }.task {
            await store.refreshView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
