//
//  SearchResponse.swift
//  PodcastApp
//
//  Created by Abrar on 16/10/2025.
//

import Foundation

// MARK: - SearchResponse
struct SearchDTO: Codable {
    let sections: [SearchSectionDTO]?
}

// MARK: - Section
struct SearchSectionDTO: Codable {
    let name, type, contentType, order: String?
    let content: [SearchContentDTO]?

    enum CodingKeys: String, CodingKey {
        case name, type, order, content
        case contentType = "content_type"
    }
}

// MARK: - Content
struct SearchContentDTO: Codable {
    let podcastID: String?
    let name: String?
    let description: String?
    let avatarURL: String?
    let episodeCount: String?
    let duration: String?
    let language: String?
    let priority: String?
    let popularityScore: String?
    let score: String?

    enum CodingKeys: String, CodingKey {
        case podcastID = "podcast_id"
        case avatarURL = "avatar_url"
        case episodeCount = "episode_count"
        case name, description, duration, language, priority, popularityScore, score
    }
}
