//
//  BlogPost.swift
//  BlogApp
//
//  Created by Dan on 18/01/2022.
//

import Foundation

struct BlogPost : Identifiable {
    let id = UUID()
    var title : String
    var subtitle : String
//    var image : URL?
    var image : String
    var blogpost : String
    var featured = false
}

var articleList : [BlogPost] = []
