//
//  FetchHomeSectionsUseCase.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

import Foundation

class FetchHomeSectionsUseCase {
    private let repository = PodacstRepositoryImplementation()
    
    func execute() async throws -> AllSectionsEntity {
        return try await repository.fetchHomeSections()
    }
}
