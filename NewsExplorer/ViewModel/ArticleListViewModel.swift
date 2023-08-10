//
//  ArticleListViewModel.swift
//  NewsExplorer
//
//  Created by Mikhayl Romanovsky on 2023/8/9.
//

import SwiftUI
import Foundation

class ArticleListViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var searchText = ""
    @Published var isLoading = false
    @Published var showingSortOptions = false
    @Published var currentSortOption: SortOption = .publishedAt
    @Published var isDatePickersPresented = false
    @Published var startDate = Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date() {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            toDateString = dateFormatter.string(from: startDate)
        }
    }
    @Published var endDate = Date() {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            fromDateString = dateFormatter.string(from: endDate)
        }
    }
    
    let maxDate = Date()
    private var fromDateString: String?
    private var toDateString: String?
    
    func fetchArticles() {
        isLoading = true
        
        NewsAPIService().fetchArticles(query: searchText,
                                       from: fromDateString,
                                       to: fromDateString,
                                       sortBy: currentSortOption.rawValue) { result in
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = false
            }
            switch result {
            case .success(let articles):
                DispatchQueue.main.async { [weak self] in
                    self?.articles = articles
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
