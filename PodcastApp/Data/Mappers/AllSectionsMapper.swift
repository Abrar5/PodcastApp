//
//  HomeSectionsMapper.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

import Foundation

extension AllSectionsEntity {
    init(dto: AllSectionsDTO) {
        self.sections = dto.sections?.compactMap { SectionEntity(dto: $0)} ?? []
        self.pagination = PaginationEntity(dto: dto.pagination)
    }
}

extension PaginationEntity {
    init(dto: PaginationDTO?) {
        self.nextPage = dto?.nextPage
        self.totalPages = dto?.totalPages
    }
}

extension SectionEntity {
    init(dto: SectionDTO?) {
        self.name = dto?.name ?? ""
        self.type = dto?.type ?? ""
        self.contentType = dto?.contentType ?? .none
        self.order = dto?.order ?? 0
        self.content = dto?.content?.map { ContentEntity(dto: $0) } ?? []
        
        self.displayStyle = ContentDisplayType(rawValue: dto?.type ?? "")
        self.viewableContent = dto?.content?.map { ViewableContent(dto: $0) } ?? []
    }
}

extension ContentEntity {
    init(dto: ContentDTO) {
        self.podcastID = dto.podcastID
        self.name = dto.name
        self.description = dto.description
        self.avatarURL = dto.avatarURL
        self.episodeCount = dto.episodeCount
        self.duration = dto.duration
        self.language = LanguageEntity(rawValue: dto.language?.rawValue ?? "")
        self.priority = dto.priority
        self.popularityScore = dto.popularityScore
        self.score = dto.score
        self.podcastPopularityScore = dto.podcastPopularityScore
        self.podcastPriority = dto.podcastPriority
        self.episodeID = dto.episodeID
        self.seasonNumber = dto.seasonNumber
        self.episodeType = EpisodeTypeEntity(rawValue: dto.episodeType?.rawValue ?? "")
        self.podcastName = dto.podcastName
        self.authorName = dto.authorName
        self.number = dto.number
        self.separatedAudioURL = dto.separatedAudioURL
        self.audioURL = dto.audioURL
        self.releaseDate = dto.releaseDate
        self.chapters = dto.chapters
        self.paidIsEarlyAccess = dto.paidIsEarlyAccess ?? false
        self.paidIsNowEarlyAccess = dto.paidIsNowEarlyAccess ?? false
        self.paidIsExclusive = dto.paidIsExclusive ?? false
        self.paidTranscriptURL = dto.paidTranscriptURL
        self.freeTranscriptURL = dto.freeTranscriptURL
        self.paidIsExclusivePartially = dto.paidIsExclusivePartially ?? false
        self.paidExclusiveStartTime = dto.paidExclusiveStartTime
        self.paidEarlyAccessDate = dto.paidEarlyAccessDate
        self.paidEarlyAccessAudioURL = dto.paidEarlyAccessAudioURL
        self.paidExclusivityType = dto.paidExclusivityType
        self.audiobookID = dto.audiobookID
        self.articleID = dto.articleID
    }
}

extension ViewableContent {
    init(dto: ContentDTO) {
        self.imageUrl = dto.avatarURL ?? ""
        self.name = dto.name ?? ""
        self.description = dto.description ?? ""
        self.duration = formatDuration(seconds: dto.duration ?? 0)
        self.releaseDate = dto.releaseDate ?? ""
        self.episodeCount = dto.episodeCount?.description ?? ""
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
