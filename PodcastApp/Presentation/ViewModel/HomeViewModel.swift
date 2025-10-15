//
//  HomeViewModel.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var homeSections: HomeResponse?
    @Published var search: SearchResponse?
    
    func getHomeSections() async {
        do {
            let homeSections = try await FetchHomeSectoinsUseCase().execute()
            print("-- \(homeSections)")
            
            self.homeSections = homeSections
        } catch {
            print(error.localizedDescription)
        }

    }
    
    func getSearch(query: String) async {
        do {
            let search = try await SearchUseCase(query: query).execute()
            print("-- \(search)")
            self.search = search
        } catch {
            print(error.localizedDescription)
        }
    }
}
