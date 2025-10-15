//
//  SearchResponse.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

import Foundation

struct SearchResponse: Decodable {
    let sections: [SectionResponse]
}

struct SectionResponse: Decodable, Identifiable {
    var id = UUID()
    let name: String
    let type: String
    let contentType: String
    let order: String
    let content: [PodcastResponse]
}

struct PodcastResponse: Decodable, Identifiable {
    var id = UUID()
    let podcastId: String
    let name: String
    let description: String
    let avatarUrl: String
    let episodeCount: String
    let duration: String       
    let language: String
    let priority: String
    let popularityScore: String
    let score: String
}

