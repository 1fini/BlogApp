//
//  BlogPost.swift
//  BlogApp
//
//  Created by Dan on 18/01/2022.
//

import Foundation
import SwiftUI
import WebKit
import UIKit

struct BlogPost : Identifiable {
    let id = UUID()
    var title : String
    var subtitle : String
    var image : String
    var blogpost : String
    var featured = false
}

struct Post : Codable {
    var id : Int
    var slug : String
    var links : Links
    var title : Rendered
    var excerpt : Excerpt
    
    enum CodingKeys: String, CodingKey {
        case links = "_links"
        case id
        case slug
        case title
        case excerpt
    }
}

struct Excerpt : Codable {
    var rendered : String
}

struct Rendered : Codable {
    var rendered : String
}

struct Links : Codable {
    var attachment : [Href]
    
    enum CodingKeys: String, CodingKey {
        case attachment = "wp:attachment"
    }
}

struct Href : Codable {
    var href : String
}

struct Media : Codable {
//    var id : Int
//    var link : String
    var guid : Rendered
//    var date : Date
}

struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0, user-scalable=no'></header>"
        uiView.loadHTMLString(headerString + htmlContent, baseURL: nil)
    }
}


var articleList : [BlogPost] = []
