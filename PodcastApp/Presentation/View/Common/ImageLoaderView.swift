//
//  ImageLoaderView.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

import SwiftUI

struct ImageLoaderView: View {
    var url: String
    
    var body: some View {
        VStack {
            if let url = URL(string: url) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .cornerRadius(8)
                    case .failure:
                        Image(systemName: "photo.circle")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
        }
    }
}
