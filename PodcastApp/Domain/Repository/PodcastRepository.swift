//
//  PodcastRepository.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

import Foundation

protocol PodcastRepository {
    func fetchHomeSections() async throws -> HomeResponse
    func search(query: String) async throws -> SearchResponse 
}
