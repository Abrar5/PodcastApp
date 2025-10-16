//
//  PodacstRepositoryImplementation.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

import Foundation

final class PodacstRepositoryImplementation: PodcastRepository {
    private let api = APIClient.shared
    
    func fetchHomeSections() async throws -> AllSectionsEntity {
        let target = PodcastTarget.homeSections
        
        let result = try await api.fetchWithRetry(target,responseType: AllSectionsDTO.self)//request(target, responseType: HomeDTO.self)
        let sections = AllSectionsEntity(dto: result)
        return sections
    }
    
    func search(query: String) async throws -> SearchEntity {
        let target = PodcastTarget.search(query: query)
        let result = try await api.request(target, responseType: SearchDTO.self)
        let sections = SearchEntity(dto: result)
        return sections
    }
}
