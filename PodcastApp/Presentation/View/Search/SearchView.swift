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
            if let sections = viewModel.homeSections?.sections.sorted(by: { $0.order < $1.order }), !searchText.isEmpty {
                ForEach(sections) { item in
                    Text(item.name)
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search...")
        .onChange(of: searchText) {
            Task {
                await viewModel.getSearch(query: searchText)
            }
        }
    }
}
