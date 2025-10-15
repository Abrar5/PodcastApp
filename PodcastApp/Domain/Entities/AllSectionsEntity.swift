//
//  AllSectionsEntity.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

import Foundation

struct AllSectionsEntity: Codable {
    var sections: [SectionEntity]
}

struct SectionEntity: Codable, Identifiable {
    var id = UUID()
    var name: String
    var type: String
    var contentType: String
    var order: Int
    var content: [ContentEntity]
}

enum ContentEntity: Codable, Identifiable {
    case podcast(PodcastEntity)
    case episode(EpisodeEntity)
    case audiobook(AudiobookEntity)
    case article(AudioArticleEntity)
    
    var id: String {
        switch self {
        case .podcast(let p): return p.podcastID
        case .episode(let e): return e.episodeID
        case .audiobook(let a): return a.audiobookID
        case .article(let a): return a.articleID
        }
    }
    
    // MARK: Codable
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let podcast = try? container.decode(PodcastEntity.self) {
            self = .podcast(podcast)
        } else if let episode = try? container.decode(EpisodeEntity.self) {
            self = .episode(episode)
        } else if let audiobook = try? container.decode(AudiobookEntity.self) {
            self = .audiobook(audiobook)
        } else if let article = try? container.decode(AudioArticleEntity.self) {
            self = .article(article)
        } else {
            throw DecodingError.typeMismatch(
                ContentEntity.self,
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Unknown content type"
                )
            )
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .podcast(let p): try container.encode(p)
        case .episode(let e): try container.encode(e)
        case .audiobook(let a): try container.encode(a)
        case .article(let a): try container.encode(a)
        }
    }
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
