//
//  BlogPostStore.swift
//  BlogApp
//
//  Created by Dan on 18/01/2022.
//

import SwiftUI
import WebKit
import Foundation

class BlogPostsStore: ObservableObject {
    @Published var blogPosts: [BlogPost] = articleList
    
    func loadMediaData(mediaData: String) async -> String {
        guard let url = URL(string:mediaData)
        else {
            print("Invalid URL")
            return ""
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode([Media].self, from: data){
                return decodedResponse.first?.guid.rendered ?? ""
            }
        } catch {
            print("Invalid Media Data")
            return ""
        }
        return ""
    }
    
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
                        Task {
                            let imageString = await self.loadMediaData(mediaData: item.links.attachment.first?.href ?? "")

                            self.blogPosts.append(
                                BlogPost(
                                    title : item.title.rendered,
                                    subtitle: item.excerpt.rendered,
                                    image: imageString,
                                    blogpost: item.excerpt.rendered,
                                    featured: false
                                )
                            )
                        }
                    }
                }
            }
        } catch {
            print("Invalid data")
        }
    }
}
