//
//  BlogPostStore.swift
//  BlogApp
//
//  Created by Dan on 18/01/2022.
//

import SwiftUI
import Foundation

class BlogPostsStore: ObservableObject {
    @Published var blogPosts: [BlogPost] = articleList
    
//    init() async {
//        DispatchQueue.main.async {
//            self.refreshView()
//        }
//    }
    
    func refreshView() async {
        blogPosts = []
        guard let url = URL(string: "https://www.parentsimpliques.fr/wp-json/wp/v2/posts") else {
            print("Invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            // more code to come
            if let decodedResponse = try? JSONDecoder().decode([Post].self, from: data) {
                decodedResponse.forEach {item in
                    DispatchQueue.main.async {
                        self.blogPosts.append(
                            BlogPost(
                                title : item.title.rendered,
                                subtitle: item.excerpt.rendered,
                                image: "https://www.parentsimpliques.fr/wp-content/uploads/2021/01/C56895D7-40B2-494B-94BB-B34763E00378-1024x1024.png",
                                blogpost: item.excerpt.rendered,
                                featured: false
                            )
                        )
                    }
                }
            }
        } catch {
            print("Invalid data")
        }
    }
}
