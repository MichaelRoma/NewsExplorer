//
//  AsyncImage.swift
//  NewsExplorer
//
//  Created by Mikhayl Romanovsky on 2023/8/10.
//

import SwiftUI

struct AsyncImage: View {
    @ObservedObject private var loader: ImageLoader
    
    init(urlString: String) {
        loader = ImageLoader()
        loader.loadImage(from: urlString)
    }
    
    var body: some View {
        if let image = loader.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        } else {
            ProgressView()
        }
    }
}
