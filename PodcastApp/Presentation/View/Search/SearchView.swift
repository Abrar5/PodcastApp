//
//  SearchView.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SectionsViewModel()
    @State var searchText: String = ""

    
    var body: some View {
        VStack {
            switch viewModel.searchLoadingType {
            case .loading:
                ProgressView()
            case .done:
                contentView
            case .empty:
                Text("No result found")
                    .foregroundColor(.white)
                    .font(AppFonts.semiBold(size: 16))
            case .error:
                Text("Something went wrong")
                    .foregroundColor(.white)
                    .font(AppFonts.semiBold(size: 16))
            default:
                EmptyView()
            }
        }
        .searchable(text: $searchText, prompt: "Search...")
        .onChange(of: searchText) {
            viewModel.search(query:searchText)
        }
    }
    
    private var contentView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if let sections = viewModel.search?.sections?.sorted(by: { Int($0.order ?? "") ?? 0 < Int($1.order ?? "") ?? 0 }), !searchText.isEmpty {
                ForEach(sections) { item in
                    ForEach(item.content ?? []) { subItem in
                        HStack(spacing: 8) {
                            ImageLoaderView(url: subItem.avatarURL ?? "")
                                .frame(width: 100, height: 100)
                            
                            VStack(alignment: .leading) {
                                Text(subItem.name ?? "")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(AppFonts.bold(size: 16))
                                
                                Text(subItem.description ?? "")
                                    .lineLimit(1)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(AppFonts.text(size: 12))

                                
                                HStack {
                                    Spacer()
                                    Image(systemName: "play.circle.fill")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 25, height: 25, alignment: .trailing)
                                }
                                Spacer()
                                
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(16)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    }
                }
            }
            Spacer()
        }
        .padding([.top, .horizontal], 12)
    }
}
