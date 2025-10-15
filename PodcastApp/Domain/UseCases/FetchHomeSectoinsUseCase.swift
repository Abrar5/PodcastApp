//
//  FetchHomeSectoinsUseCase.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

import Foundation

class FetchHomeSectoinsUseCase {
    private let repository = PodacstRepositoryImplementation()
    
    func execute() async throws -> AllSectionsEntity {
        return try await repository.fetchHomeSections()
    }
}
