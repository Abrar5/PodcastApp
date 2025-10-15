//
//  AllSectionsDTO.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

import Foundation

struct AllSectionsDTO: Codable {
    let sections: [SectionDTO]
}

struct SectionDTO: Codable, Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let contentType: String
    let order: Int
    let content: [ContentDTO]

    enum CodingKeys: String, CodingKey {
        case name, type, order, content
        case contentType = "content_type"
    }
}

enum ContentDTO: Codable, Identifiable {
    case podcast(PodcastDTO)
    case episode(EpisodeDTO)
    case audiobook(AudiobookDTO)
    case article(AudioArticleDTO)
    
    var id: String {
        switch self {
        case .podcast(let p): return p.podcastID
        case .episode(let e): return e.episodeID
        case .audiobook(let a): return a.audiobookID
        case .article(let a): return a.articleID
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let podcast = try? container.decode(PodcastDTO.self) {
            self = .podcast(podcast)
        } else if let episode = try? container.decode(EpisodeDTO.self) {
            self = .episode(episode)
        } else if let audiobook = try? container.decode(AudiobookDTO.self) {
            self = .audiobook(audiobook)
        } else if let article = try? container.decode(AudioArticleDTO.self) {
            self = .article(article)
        } else {
            throw DecodingError.typeMismatch(ContentDTO.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unknown content type"))
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
struct PodcastDTO: Codable {
    let podcastID, name, description: String
    let avatarURL: String
    let episodeCount, duration: Int
    let language: String?
    let priority, popularityScore: Int
    let score: Double

    enum CodingKeys: String, CodingKey {
        case podcastID = "podcast_id"
        case name, description
        case avatarURL = "avatar_url"
        case episodeCount = "episode_count"
        case duration, language, priority, popularityScore, score
    }
}

// MARK: - Episode
struct EpisodeDTO: Codable {
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

    enum CodingKeys: String, CodingKey {
        case podcastPopularityScore, podcastPriority
        case episodeID = "episode_id"
        case name
        case seasonNumber = "season_number"
        case episodeType = "episode_type"
        case podcastName = "podcast_name"
        case authorName = "author_name"
        case description, number, duration
        case avatarURL = "avatar_url"
        case separatedAudioURL = "separated_audio_url"
        case audioURL = "audio_url"
        case releaseDate = "release_date"
        case podcastID = "podcast_id"
        case chapters
        case paidIsEarlyAccess = "paid_is_early_access"
        case paidIsNowEarlyAccess = "paid_is_now_early_access"
        case paidIsExclusive = "paid_is_exclusive"
        case paidTranscriptURL = "paid_transcript_url"
        case freeTranscriptURL = "free_transcript_url"
        case paidIsExclusivePartially = "paid_is_exclusive_partially"
        case paidExclusiveStartTime = "paid_exclusive_start_time"
        case paidEarlyAccessDate = "paid_early_access_date"
        case paidEarlyAccessAudioURL = "paid_early_access_audio_url"
        case paidExclusivityType = "paid_exclusivity_type"
        case score
    }
}

// MARK: - Audiobook
struct AudiobookDTO: Codable {
    let audiobookID, name, authorName, description: String
    let avatarURL: String
    let duration: Int
    let language: String?
    let releaseDate: String
    let score: Double

    enum CodingKeys: String, CodingKey {
        case audiobookID = "audiobook_id"
        case name, authorName = "author_name", description
        case avatarURL = "avatar_url"
        case duration, language
        case releaseDate = "release_date"
        case score
    }
}

// MARK: - AudioArticle
struct AudioArticleDTO: Codable {
    let articleID, name, authorName, description: String
    let avatarURL: String
    let duration: Int
    let releaseDate: String
    let score: Double

    enum CodingKeys: String, CodingKey {
        case articleID = "article_id"
        case name, authorName = "author_name", description
        case avatarURL = "avatar_url"
        case duration
        case releaseDate = "release_date"
        case score
    }
}
