//
//  AllSectionsEntity.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

import Foundation

struct AllSectionsEntity {
    let sections: [SectionEntity]?
    let pagination: PaginationEntity?
}

// MARK: - Pagination
struct PaginationEntity {
    let nextPage: String?
    let totalPages: Int?
}

// MARK: - Section
struct SectionEntity: Identifiable {
    var id = UUID()
    var name, type, contentType: String?
    let order: Int?
    let content: [ContentEntity]?
    
    let displayStyle: ContentDisplayType?
    var viewableContent: [ViewableContent] = []
}

// MARK: - Content
struct ContentEntity {
    let podcastID: String?
    let name, description: String?
    let avatarURL: String?
    let episodeCount: Int?
    let duration: Int?
    let language: LanguageEntity?
    let priority, popularityScore: Int?
    let score: Double?
    let podcastPopularityScore, podcastPriority: Int?
    let episodeID: String?
    let seasonNumber: Int?
    let episodeType: EpisodeTypeEntity?
    let podcastName: String?
    let authorName: String?
    let number: Int?
    let separatedAudioURL, audioURL: String?
    let releaseDate: String?
    let chapters: [Int]?
    let paidIsEarlyAccess, paidIsNowEarlyAccess, paidIsExclusive: Bool?
    let paidTranscriptURL, freeTranscriptURL: String?
    let paidIsExclusivePartially: Bool?
    let paidExclusiveStartTime: Int?
    let paidEarlyAccessDate, paidEarlyAccessAudioURL, paidExclusivityType: String?
    let audiobookID: String?
    let articleID: String?
}

enum EpisodeTypeEntity: String, Codable {
    case full = "full"
    case trailer = "trailer"
}

enum LanguageEntity: String, Codable {
    case en = "en"
}

struct ViewableContent: Identifiable {
    var id = UUID()
    var imageUrl: String = ""
    var name: String = ""
    var description: String = ""
    var duration: String = ""
    var releaseDate: String = ""
    var episodeCount: String = ""
}
