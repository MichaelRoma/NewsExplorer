//
//  ArticleRow.swift
//  NewsExplorer
//
//  Created by Mikhayl Romanovsky on 2023/8/9.
//

import SwiftUI

struct ArticleRow: View {
    var article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(article.title ?? "")
                .font(.headline)
            
            Text(article.description ?? "")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}
