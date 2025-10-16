//
//  SearchEntity.swift
//  PodcastApp
//
//  Created by Abrar on 16/10/2025.
//

import Foundation

struct SearchEntity {
    let sections: [SearchSectionEntity]?
}

struct SearchSectionEntity: Identifiable, Codable {
    var id = UUID()
    let name, type, contentType, order: String?
    let content: [SearchContentEntity]?
}

struct SearchContentEntity: Identifiable, Codable {
    let id = UUID()
    let podcastID, name, description: String?
    let avatarURL: String?
    let episodeCount, duration, language, priority: String?
    let popularityScore, score: String?
}
