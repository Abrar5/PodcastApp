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
    @Published var homeSections: AllSectionsEntity? {
        didSet {
            filteredSections = updateFilterSections()
        }
    }
    @Published var filteredSections: [SectionEntity] = []
    
    var selectedType: ContentType = .podcast {
        didSet {
            filteredSections = updateFilterSections()
        }
    }
        
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
}
