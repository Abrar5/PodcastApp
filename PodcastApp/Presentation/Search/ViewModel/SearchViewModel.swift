//
//  SearchViewModel.swift
//  PodcastApp
//
//  Created by Abrar on 18/10/2025.
//

import Foundation

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchLoadingType: LoadingType = .none
    @Published var search: SearchEntity?
    @Published private var searchTask: Task<Void, Never>? = nil
  
    private var shouldGetSearchResults: Bool = false
    private let debounceTime: UInt64 = 200_000_000
        
    func getSearch(query: String) async {
        searchLoadingType = .loading
        do {
            let search = try await SearchUseCase(query: query).execute()
            print("-- \(search)")
            self.search = search
            searchLoadingType = updateSearchLoadingState(search.sections ?? [])
        } catch {
            search = stubSearchSections(query: query)
            print(error.localizedDescription)
            searchLoadingType = updateErrorIndicatorLoadingState(shouldGetSearchResults: shouldGetSearchResults)
        }
    }
    
    func search(query: String) {
        searchTask?.cancel()
        
        guard !query.isEmpty else {
            return
        }

        searchTask = Task {
            do {
                try await Task.sleep(nanoseconds: debounceTime)
                try Task.checkCancellation()
                shouldGetSearchResults = true
                await getSearch(query: query)
            } catch is CancellationError {
                shouldGetSearchResults = false
                print("Search cancelled user is currently typing")
            } catch {
                print("Search failed: \(error.localizedDescription)")
            }
        }
    }
          
    private func updateSearchLoadingState(_ sections: [SearchSectionEntity]) -> LoadingType {
         if sections.count == 0 {
             return .empty
         } else {
            return .done
         }
     }
    
    private func updateErrorIndicatorLoadingState(shouldGetSearchResults: Bool = false) -> LoadingType {
        if shouldGetSearchResults {
            /** when user is still typing, show nothing until the user stop typing  **/
            self.shouldGetSearchResults = false
            return .none
        } else {
            return .error
        }
    }
    
    private func stubSearchSections(query: String) -> SearchEntity {
        guard let path = Bundle.main.path(forResource: "GetSearch", ofType: "json") else {
            fatalError("GetSearch.json not found in bundle.")
        }
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let sections = try! decoder.decode(SearchDTO.self, from: data)
        let searchResult = SearchEntity(dto: sections).sections?.filter {
            $0.name?.lowercased().contains(query.lowercased()) ?? false
        }
        let entity = SearchEntity(sections: searchResult)
        searchLoadingType = updateSearchLoadingState(entity.sections ?? [])
        return entity
    }
}
