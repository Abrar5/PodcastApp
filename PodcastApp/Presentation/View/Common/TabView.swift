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
            NavigationView {
                HomeView()
            }
            .tabItem {
                Image(systemName: "house.fill")
                    .accessibilityIdentifier("HomeTabImage")
            }
            .accessibilityIdentifier("HomeTabContainer")
            
            NavigationView {
                SearchView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                    .accessibilityIdentifier("SearchTabImage")
            }
            .accessibilityIdentifier("SearchTabContainer")
        }
        .preferredColorScheme(.dark)
        .background(.black)
        .accentColor(.white)
    }
}
