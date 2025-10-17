//
//  HomeSectionsMapper.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

import Foundation

extension AllSectionsEntity {
    init(dto: AllSectionsDTO) {
        self.sections = dto.sections.compactMap { SectionEntity(dto: $0)}
    }
}

extension SectionEntity {
    init(dto: SectionDTO) {
        self.name = dto.name ?? ""
        self.displayStyle = ContentDisplayType(rawValue: dto.type ?? "") ?? .none
        self.contentType = dto.contentType ?? ""
        self.order = dto.order ?? 0
        self.content = dto.content?.map { ContentEntityType(dto: $0) } ?? []
        self.viewableContent = dto.content?.map { ViewableContent(dto: $0) } ?? []
    }
}

extension ViewableContent {
    init(dto: ContentDTO) {
        switch dto {
        case .podcast(let podcast):
            self.imageUrl = podcast.avatarURL ?? ""
            self.name = podcast.name ?? ""
            self.description = podcast.description ?? ""
            self.duration = formatDuration(seconds: podcast.duration ?? 0)
            self.releaseDate = ""
            self.episodeCount = podcast.episodeCount?.description ?? ""
            
        case .episode(let episode):
            self.imageUrl = episode.avatarURL ?? ""
            self.name = episode.name ?? ""
            self.description = episode.description ?? ""
            self.duration = formatDuration(seconds: episode.duration ?? 0)
            self.releaseDate = episode.releaseDate ?? ""
            self.episodeCount = ""
            
        case .audiobook(let audiobook):
            self.imageUrl = audiobook.avatarURL ?? ""
            self.name = audiobook.name ?? ""
            self.description = audiobook.description ?? ""
            self.duration = formatDuration(seconds: audiobook.duration ?? 0)
            self.releaseDate = audiobook.releaseDate ?? ""
            self.episodeCount = ""
        case .article(let article):
            self.imageUrl = article.avatarURL ?? ""
            self.name = article.name ?? ""
            self.description = article.description ?? ""
            self.duration = formatDuration(seconds: article.duration ?? 0)
            self.releaseDate = article.releaseDate ?? ""
            self.episodeCount = ""
        }
    }
    
    func formatDuration(seconds: Int) -> String {
        guard seconds > 0 else { return "0 min" }
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .short
        formatter.zeroFormattingBehavior = .dropAll
        
        if let formattedString = formatter.string(from: TimeInterval(seconds)) {
            return formattedString
                .replacingOccurrences(of: "hr", with: "h")
                .replacingOccurrences(of: "min", with: "m")
                .replacingOccurrences(of: "sec", with: "s")
        }
        
        return ""
    }
}

extension ContentEntityType {
    init(dto: ContentDTO) {
        switch dto {
        case .podcast(let podcast):
            self = .podcast(PodcastEntity(dto: podcast))
        case .episode(let episode):
            self = .episode(EpisodeEntity(dto: episode))
        case .audiobook(let audiobook):
            self = .audiobook(AudiobookEntity(dto: audiobook))
        case .article(let article):
            self = .article(AudioArticleEntity(dto: article))
        }
    }
}

extension PodcastEntity {
    init(dto: PodcastDTO) {
        self.podcastID = dto.podcastID ?? ""
        self.name = dto.name ?? ""
        self.description = dto.description ?? ""
        self.avatarURL = dto.avatarURL ?? ""
        self.episodeCount = dto.episodeCount ?? 0
        self.duration = dto.duration ?? 0
        self.language = dto.language
        self.priority = dto.priority ?? 0
        self.popularityScore = dto.popularityScore ?? 0
        self.score = dto.score ?? 0
    }
}

extension EpisodeEntity {
    init(dto: EpisodeDTO) {
        self.podcastPopularityScore = dto.podcastPopularityScore ?? 0
        self.podcastPriority = dto.podcastPriority ?? 0
        self.episodeID = dto.episodeID ?? ""
        self.name = dto.name ?? ""
        self.seasonNumber = dto.seasonNumber
        self.episodeType = dto.episodeType ?? ""
        self.podcastName = dto.podcastName ?? ""
        self.authorName = dto.authorName ?? ""
        self.description = dto.description ?? ""
        self.number = dto.number
        self.duration = dto.duration ?? 0
        self.avatarURL = dto.avatarURL ?? ""
        self.separatedAudioURL = dto.separatedAudioURL ?? ""
        self.audioURL = dto.audioURL ?? ""
        self.releaseDate = dto.releaseDate ?? ""
        self.podcastID = dto.podcastID ?? ""
        self.chapters = dto.chapters ?? []
        self.paidIsEarlyAccess = dto.paidIsEarlyAccess ?? false
        self.paidIsNowEarlyAccess = dto.paidIsNowEarlyAccess ?? false
        self.paidIsExclusive = dto.paidIsExclusive ?? false
        self.paidTranscriptURL = dto.paidTranscriptURL
        self.freeTranscriptURL = dto.freeTranscriptURL
        self.paidIsExclusivePartially = dto.paidIsExclusivePartially ?? false
        self.paidExclusiveStartTime = dto.paidExclusiveStartTime ?? 0
        self.paidEarlyAccessDate = dto.paidEarlyAccessDate
        self.paidEarlyAccessAudioURL = dto.paidEarlyAccessAudioURL
        self.paidExclusivityType = dto.paidExclusivityType
        self.score = dto.score ?? 0
    }
}

extension AudiobookEntity {
    init(dto: AudiobookDTO) {
        self.audiobookID = dto.audiobookID ?? ""
        self.name = dto.name ?? ""
        self.authorName = dto.authorName ?? ""
        self.description = dto.description ?? ""
        self.avatarURL = dto.avatarURL ?? ""
        self.duration = dto.duration ?? 0
        self.language = dto.language
        self.releaseDate = dto.releaseDate ?? ""
        self.score = dto.score ?? 0
    }
}

extension AudioArticleEntity {
    init(dto: AudioArticleDTO) {
        self.articleID = dto.articleID ?? ""
        self.name = dto.name ?? ""
        self.authorName = dto.authorName ?? ""
        self.description = dto.description ?? ""
        self.avatarURL = dto.avatarURL ?? ""
        self.duration = dto.duration ?? 0
        self.releaseDate = dto.releaseDate ?? ""
        self.score = dto.score ?? 0
    }
}
