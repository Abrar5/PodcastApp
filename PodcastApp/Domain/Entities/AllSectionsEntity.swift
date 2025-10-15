//
//  AllSectionsEntity.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

import Foundation

struct AllSectionsEntity {
    var sections: [SectionEntity]
}

struct SectionEntity: Identifiable {
    var id = UUID()
    var name: String
    var displayStyle: ContentDisplayType
    var contentType: String
    var order: Int
    var content: [ContentEntityType]
    var viewableContent: [ViewableContent]
}

struct ViewableContent: Identifiable {
    var id = UUID()
    var imageUrl: String = ""
    var name: String = ""
    var duration: String = ""
    var releaseDate: String = ""
    var episodeCount: String = ""
}

// MARK: - Podcast
struct PodcastEntity: Codable {
    let podcastID, name, description: String
    let avatarURL: String
    let episodeCount, duration: Int
    let language: String?
    let priority, popularityScore: Int
    let score: Double
}

// MARK: - Episode
struct EpisodeEntity: Codable {
    let podcastPopularityScore, podcastPriority: Int
    let episodeID, name: String
    let seasonNumber: Int?
    let episodeType, podcastName, authorName, description: String
    let number: Int?
    let duration: Int
    let avatarURL, separatedAudioURL, audioURL: String
    let releaseDate, podcastID: String
    let chapters: [String]
    let paidIsEarlyAccess, paidIsNowEarlyAccess, paidIsExclusive: Bool
    let paidTranscriptURL, freeTranscriptURL: String?
    let paidIsExclusivePartially: Bool
    let paidExclusiveStartTime: Int
    let paidEarlyAccessDate, paidEarlyAccessAudioURL, paidExclusivityType: String?
    let score: Double
}

// MARK: - Audiobook
struct AudiobookEntity: Codable {
    let audiobookID, name, authorName, description: String
    let avatarURL: String
    let duration: Int
    let language: String?
    let releaseDate: String
    let score: Double
}

// MARK: - AudioArticle
struct AudioArticleEntity: Codable {
    let articleID, name, authorName, description: String
    let avatarURL: String
    let duration: Int
    let releaseDate: String
    let score: Double
}
