//
//  PodacstRepositoryImplementation.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

import Foundation

final class PodacstRepositoryImplementation: PodcastRepository {
    private let api = APIClient.shared

    func fetchHomeSections() async throws -> HomeResponse {
        let target = PodcastTarget.homeSections
        
        return try await api.fetchWithRetry(target,responseType: HomeResponse.self)//request(target, responseType: HomeResponse.self)
    }

    func search(query: String) async throws -> SearchResponse {
        let target = PodcastTarget.search(query: query)
        return try await api.request(target, responseType: SearchResponse.self)
    }
}
