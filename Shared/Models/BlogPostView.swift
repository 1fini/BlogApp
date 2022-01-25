//
//  BlogPostView.swift
//  BlogApp
//
//  Created by Dan on 21/01/2022.
//

import SwiftUI

struct BlogPostView: View {
    
    var blogPost: BlogPost
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
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
                    
                    VStack {
                        HStack {
                            Text(blogPost.title)
                                .font(.title3)
                                .fontWeight(.heavy)
                                .foregroundColor(.primary)
                                .lineLimit(3)
                                .padding(.vertical, 15)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                                                
                            HTMLStringView(htmlContent: blogPost.blogpost)
                            .multilineTextAlignment(.leading)
                            .font(.body)
                            .foregroundColor(Color.primary.opacity(0.9))
                            .padding(.bottom, 25)
                            .frame(maxWidth: .infinity)
                            .frame(height: 500)
                    }
                    .padding(.horizontal, 20)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//struct BlogPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        BlogPostView()
//    }
//}
