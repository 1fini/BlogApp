//
//  WebView.swift
//  BlogApp
//
//  Created by Dan on 16/01/2022.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var text : String
    
    func makeUIView(context: Context) -> some WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.loadHTMLString(text, baseURL: nil)
    }
}
