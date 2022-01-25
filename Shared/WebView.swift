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

struct HTMLText: UIViewRepresentable {

   let html: String
    
   func makeUIView(context: UIViewRepresentableContext<Self>) -> UILabel {
        let label = UILabel()
        DispatchQueue.main.async {
            let data = Data(self.html.utf8)
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                label.attributedText = attributedString
            }
        }

        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {}
}
