//
//  Article.swift
//  NewsExplorer
//
//  Created by Mikhayl Romanovsky on 2023/8/9.
//

import Foundation
import SwiftUI

struct Article: Codable, Hashable, Identifiable {
    var id = UUID()
    func hash(into hasher: inout Hasher) { hasher.combine(id)}
    static func == (lhs: Article, rhs: Article) -> Bool { return lhs.id == rhs.id}
    
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    struct Source:Codable {
        let id: String?
        let name: String?
    }
    
    enum CodingKeys: String, CodingKey {
        case source, author, title, description, url, urlToImage, publishedAt, content
    }
}
