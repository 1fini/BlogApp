//
//  BlogPostCardList.swift
//  BlogApp
//
//  Created by Dan on 21/01/2022.
//

import SwiftUI

struct BlogPostCardList: View {
    var blogPost: BlogPost
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: blogPost.image)){ phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
//                        .scaledToFit()
                        .frame(height: 220)
                        .frame(maxWidth: UIScreen.main.bounds.width - 80)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                } else if phase.error != nil {
                    Text("There was an error loading the image.")
                } else {
                    ProgressView()
                }
            }
            VStack(spacing: 6) {
                HStack {
                    Text(blogPost.title)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(3)
                        .font(Font.title2.bold())
                        .foregroundColor(.primary)
                    Spacer()
                }

                HStack {
                    Text(blogPost.subtitle)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(3)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
        }
        .frame(maxWidth: UIScreen.main.bounds.width - 60, alignment: .leading)
        .padding()
    }
}

struct BlogPostCardList_Previews: PreviewProvider {
    static let store = BlogPostsStore()
    static let placeholder = BlogPost(title: "This is a placeholder", subtitle: "A subtitle for the placeholder", image: "https://media.nature.com/lw800/magazine-assets/d41586-020-03053-2/d41586-020-03053-2_18533904.jpg", blogpost: "Blog post")
    
    static var previews: some View {
        
        BlogPostCardMain(blogPost: BlogPostsStore().blogPosts.first!)
        BlogPostCardMain(blogPost: placeholder)
            .environmentObject(store)

        BlogPostCardMain(blogPost: placeholder)
            .environmentObject(store)
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
            .preferredColorScheme(.dark)
    }
}
