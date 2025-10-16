//
//  SectionsViewModel.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

import Foundation

@MainActor
class SectionsViewModel: ObservableObject {
    @Published var homeSections: AllSectionsEntity?
    @Published var search: SearchEntity?
    @Published var homeLoadingType: LoadingType = .none
    @Published var searchLoadingType: LoadingType = .none
    @Published private var searchTask: Task<Void, Never>? = nil
    private let debounceTime: UInt64 = 900_000_000
    
    func getHomeSections() async {
        homeLoadingType = .loading
        do {
            let homeSections = try await FetchHomeSectoinsUseCase().execute()
            print("-- \(homeSections)")
            self.homeSections = homeSections
            if homeSections.sections.count == 0 {
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
    
    func stubHomeSections() -> AllSectionsEntity {
        guard let path = Bundle.main.path(forResource: "GetSections", ofType: "json") else {
            fatalError("GetSections.json not found in bundle.")
        }
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let sectoins = try! decoder.decode(AllSectionsDTO.self, from: data)
        let entity = AllSectionsEntity(dto: sectoins)
        return entity
    }
    
    func stubSearchSections(query: String) -> AllSectionsEntity {
        guard let path = Bundle.main.path(forResource: "GetSections", ofType: "json") else {
            fatalError("GetSections.json not found in bundle.")
        }
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let sectoins = try! decoder.decode(AllSectionsDTO.self, from: data)
        let entity = AllSectionsEntity(dto: sectoins)
        return entity
    }
}
