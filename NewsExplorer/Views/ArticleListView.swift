//
//  ArticleListView.swift
//  NewsExplorer
//
//  Created by Mikhayl Romanovsky on 2023/8/9.
//

import SwiftUI

struct ArticleListView: View {
    @StateObject var viewModel = ArticleListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .padding()
                } else if viewModel.articles.isEmpty {
                    Text("It's empty now. Type what kind of articles you want to find")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                } else {
                    List(viewModel.articles) { article in
                        NavigationLink(destination: ArticleDetailView(article: article)) {
                            ArticleRow(article: article)}
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        TextField("Search...", text: $viewModel.searchText) {
                            viewModel.fetchArticles()
                        }.textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200)
                        Button("Sort") {
                            viewModel.showingSortOptions.toggle()
                        }
                        Button("Time period") {
                            viewModel.isDatePickersPresented.toggle()
                        }
                    }
                    
                }
            }
        }.actionSheet(isPresented: $viewModel.showingSortOptions) {
            ActionSheet(title: Text("Current option \(viewModel.currentSortOption.rawValue)"), buttons: SortOption.allCases.map({ option in
                    .default(Text(option.rawValue)) {
                        viewModel.currentSortOption = option
                    }
            }))
        }
        .sheet(isPresented: $viewModel.isDatePickersPresented) {
            VStack {
                DatePicker("Start date", selection: $viewModel.startDate, in: ...viewModel.maxDate, displayedComponents: .date)
                    .onChange(of: viewModel.startDate) { newStartDate in
                        if newStartDate > viewModel.endDate {
                            viewModel.endDate = newStartDate
                        }
                    }
                DatePicker("End date", selection: $viewModel.endDate, in: ...viewModel.maxDate, displayedComponents: .date)
                    .onChange(of: viewModel.endDate) { newEndDate in
                        if newEndDate < viewModel.startDate {
                            viewModel.startDate = newEndDate
                        }
                    }
                Button("Apply") { viewModel.isDatePickersPresented.toggle() }
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView()
    }
}
