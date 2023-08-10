//
//  ImageLoader.swift
//  NewsExplorer
//
//  Created by Mikhayl Romanovsky on 2023/8/9.
//

import SwiftUI

final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var error: NetworkError?
    enum NetworkError: Error {
        case cantCreateUrl, networkError, imageCreatingError
    }
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            error = .cantCreateUrl
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error != nil { self.error = .networkError }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            } else { self.error = .imageCreatingError }
        }.resume()
    }
}
