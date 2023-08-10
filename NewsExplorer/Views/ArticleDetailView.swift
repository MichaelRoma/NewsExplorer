//
//  ArticleDetailView.swift
//  NewsExplorer
//
//  Created by Mikhayl Romanovsky on 2023/8/9.
//

import SwiftUI

struct ArticleDetailView: View {
    let article: Article
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(urlString: article.urlToImage ?? "")
                Text(article.title ?? "")
                    .font(.title)
                Text(article.description ?? "")
                    .font(.body )
                VStack {
                    Text("Author: \(article.author ?? "")")
                        .font(.title3)
                    Text("Source: \(article.source?.name ?? "")")
                        .font(.title3)
                    Text("Published at: \(article.publishedAt ?? "")")
                    .font(.title3) }.padding(.top, 30)
            }
            .padding()
            .navigationBarTitle("Detail", displayMode: .inline)
        }
    }
}
