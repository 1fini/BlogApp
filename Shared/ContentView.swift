//
//  ContentView.swift
//  Shared
//
//  Created by Dan on 14/01/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var results = [Post]()
    
    var body: some View {
        Text("Hello, world!")
        List(results, id: \.id) {
            item in
            VStack(alignment: .leading){
                
                Text(item.title.rendered)
                    .font(.headline)
                Text(String.init(item.id))
            }
        }
        .task {
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
//        var date : Date
        var slug : String
//        var link : URL
        var title : Rendered
}

struct Rendered : Codable {
    var rendered : String
}
