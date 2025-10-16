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
    @Published var search: AllSectionsEntity?
    
    func getHomeSections() async {
        do {
            let homeSections = try await FetchHomeSectoinsUseCase().execute()
            print("-- \(homeSections)")
            
            self.homeSections = homeSections
        } catch {
            homeSections = stubHomeSections()
            print(error.localizedDescription)
        }

    }
    
    func getSearch(query: String) async {
        do {
            let search = try await SearchUseCase(query: query).execute()
            print("-- \(search)")
            self.search = search
        } catch {
            search = stubSearchSections(query: query)
            print(error.localizedDescription)
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
        let searchResult = AllSectionsEntity(dto: sectoins).sections.filter {
            $0.name.lowercased().contains(query.lowercased())
        }
        let entity = AllSectionsEntity(sections: searchResult)
        return entity
    }
}
