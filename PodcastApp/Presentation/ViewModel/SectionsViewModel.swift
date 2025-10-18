//
//  SectionsViewModel.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

import Foundation

@MainActor
class SectionsViewModel: ObservableObject {
    @Published var homeLoadingType: LoadingType = .none
    @Published var searchLoadingType: LoadingType = .none
    @Published var homeSections: AllSectionsEntity? {
        didSet {
            filteredSections = updateFilterSections()
        }
    }
    @Published var search: SearchEntity?
    @Published var filteredSections: [SectionEntity] = []
    @Published private var searchTask: Task<Void, Never>? = nil
    
    var selectedType: ContentType = .podcast {
        didSet {
            filteredSections = updateFilterSections()
        }
    }
    
    private let debounceTime: UInt64 = 200_000_000
    
    
    func getHomeSections() async {
        homeLoadingType = .loading
        do {
            let homeSections = try await FetchHomeSectionsUseCase().execute()
            print("-- \(homeSections)")
            self.homeSections = homeSections
            if homeSections.sections?.count == 0 {
                homeLoadingType = .empty
            } else {
                homeLoadingType = .done
            }
        } catch {
            homeSections = stubHomeSections()
            print(error.localizedDescription)
            homeLoadingType = .done
        }
    }
    
    func getSearch(query: String) async {
        searchLoadingType = .loading
        do {
            let search = try await SearchUseCase(query: query).execute()
            print("-- \(search)")
            self.search = search
            if search.sections?.count ?? 0 == 0 {
                searchLoadingType = .empty
            } else {
                searchLoadingType = .done
            }
        } catch {
            search = stubSearchSections(query: query)
            print(error.localizedDescription)
            searchLoadingType = .error
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
                
                await getSearch(query: query)
            } catch is CancellationError {
                print("Search cancelled user is currently typing")
            } catch {
                print("Search failed: \(error.localizedDescription)")
            }
        }
    }
    
    private func updateFilterSections() -> [SectionEntity]  {
        return  homeSections?.sections?.filter { $0.contentType == selectedType.rawValue }.sorted(by: { $0.order ?? 0 < $1.order ?? 0}) ?? []

    }
    
    func stubHomeSections() -> AllSectionsEntity {
        guard let path = Bundle.main.path(forResource: "GetSections", ofType: "json") else {
            fatalError("GetSections.json not found in bundle.")
        }
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let sections = try! decoder.decode(AllSectionsDTO.self, from: data)
        let entity = AllSectionsEntity(dto: sections)
        
        if homeSections?.sections?.count == 0 {
            homeLoadingType = .empty
        } else {
            homeLoadingType = .done
        }
        
        return entity
    }
    
    func stubSearchSections(query: String) -> SearchEntity {
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
        
        if search?.sections?.count ?? 0 == 0 {
            searchLoadingType = .empty
        } else {
            searchLoadingType = .done
        }
        
        return entity
    }
}
