//
//  HomeResponse.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

import Foundation

// MARK: - Models from API
struct HomeResponse: Decodable {
    let sections: [Section]
}

struct Pagination {
    let nextPage: String
    let totalPages: Int
}

struct Section: Decodable, Equatable, Hashable {
    let name: String?
    let type: DisplayType?
    let contentType: ContentType?
    let order: Int?
    let content: [Content]?
    
    static func == (lhs: Section, rhs: Section) -> Bool {
        return lhs.name == rhs.name
    }
}

struct Content: Decodable, Identifiable, Hashable {
    var id: String {
        podcastID ?? episodeID ?? articleID ?? UUID().uuidString
    }

    let podcastID: String?
    let audiobookID: String?
    let articleID: String?

    let name: String?
    let contentDescription: String?
    let avatarURL: String?
    let episodeCount: Int?
    let duration: Int?
    let language: Language?
    let priority: Int?
    let popularityScore: Int?
    let score: Double?
    let podcastPopularityScore: Int?
    let podcastPriority: Int?
    let episodeID: String?
    let seasonNumber: Int?
    let episodeType: EpisodeType?
    let podcastName: String?
    let authorName: String?
    let number: Int?
    let separatedAudioURL: String?
    let audioURL: String?
    let releaseDate: String?
    let paidIsEarlyAccess: Bool?
    let paidIsNowEarlyAccess: Bool?
    let paidIsExclusive: Bool?
    let paidTranscriptURL: Bool?
    let freeTranscriptURL: Bool?
    let paidIsExclusivePartially: Bool?
    let paidExclusiveStartTime: Int?
    let paidEarlyAccessDate: Bool?
    let paidEarlyAccessAudioURL: Bool?
    let paidExclusivityType: Bool?

    enum CodingKeys: String, CodingKey {
        case podcastID = "podcast_id"
        case name
        case contentDescription = "description"
        case avatarURL = "avatar_url"
        case episodeCount = "episode_count"
        case duration, language, priority, popularityScore, score
        case podcastPopularityScore, podcastPriority
        case episodeID = "episode_id"
        case seasonNumber = "season_number"
        case episodeType = "episode_type"
        case podcastName = "podcast_name"
        case authorName = "author_name"
        case number
        case separatedAudioURL = "separated_audio_url"
        case audioURL = "audio_url"
        case releaseDate = "release_date"
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
        case audiobookID = "audiobook_id"
        case articleID = "article_id"
    }
}

enum DisplayType: String, Decodable {
    case square
    case twoLinesGrid = "2_lines_grid"
    case bigSquare = "big_square"
    case queue
    
    case unknown

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self).trimmingCharacters(in: .whitespacesAndNewlines)
        self = DisplayType(rawValue: rawValue) ?? .unknown
    }
}

enum ContentType: String, Decodable, CaseIterable, Identifiable {
    case forYou = "for_you"
    case podcast
    case episode
    case audioArticle = "audio_article"
    case audioBook = "audio_book"
    
    var id: String { self.rawValue }
    var displayName: String {  self.rawValue.replacingOccurrences(of: "_", with: " ").capitalized }
}

enum EpisodeType: String, Decodable {
    case full
    case trailer
}

enum Language: String, Decodable {
    case en
    case ar
}
