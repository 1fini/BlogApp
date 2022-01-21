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
        Text("Hello, world!")
        VStack(alignment: .center){
                if(store.blogPosts.count > 0){
                BlogPostCardMain(blogPost: store.blogPosts.first!)
                    .environmentObject(store)
                }
            List(results, id: \.id) {
                item in
                VStack(alignment: .leading){
                    Text(item.title.rendered)
                        .font(.headline)
                    WebView(text: item.excerpt.rendered)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .font(.body)
                }
            }
        }
        .task {
            await store.refreshView()
            await loadData()
            
        }
    }
    
    func loadData() async {
        
        guard let url = URL(string: "https://www.parentsimpliques.fr/wp-json/wp/v2/posts") else {
            print("Invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            // more code to come
            if let decodedResponse = try? JSONDecoder().decode([Post].self, from: data) {
                results = decodedResponse
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Post : Codable {
    var id : Int
    var slug : String
    var title : Rendered
    var excerpt : Excerpt
}

struct Excerpt : Codable {
    var rendered : String
}

struct Rendered : Codable {
    var rendered : String
}

