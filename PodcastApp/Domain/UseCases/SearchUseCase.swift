//
//  SearchUseCase.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

import Foundation

class SearchUseCase {
    private let repository = PodacstRepositoryImplementation()
    private var query: String
    
    init(query: String) {
        self.query = query
    }
    func execute() async throws -> SearchResponse {
        return try await repository.search(query: query)
    }
}
