//
//  TabView.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("house")
                }

            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        }
        .background(.black)
        .accentColor(.white)
    }
}
