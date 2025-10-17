//
//  ContentType.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

enum ContentType: String, Codable, Identifiable,CaseIterable {
    case podcast
    case episode
    case audioBook = "audio_book"
    case audioArticle = "audio_article"
    
    var id: String {
        return self.rawValue
    }
    var localizedDescription: String {
        return self.rawValue.capitalized.replacingOccurrences(of: "_", with: " ")
    }
}

enum ContentEntityType: Codable, Identifiable {
    case podcast(PodcastEntity)
    case episode(EpisodeEntity)
    case audiobook(AudiobookEntity)
    case article(AudioArticleEntity)
    
    var id: String {
        switch self {
        case .podcast(let p): return p.podcastID ?? "00"
        case .episode(let e): return e.episodeID ?? "00"
        case .audiobook(let a): return a.audiobookID ?? "00"
        case .article(let a): return a.articleID ?? "00"
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
                ContentEntityType.self,
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
