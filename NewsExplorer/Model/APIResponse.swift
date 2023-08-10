//
//  APIResponse.swift
//  NewsExplorer
//
//  Created by Mikhayl Romanovsky on 2023/8/9.
//

import Foundation

struct APIResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}
