//
//  HomeSectionsMapper.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

extension AllSectionsEntity {
    init(dto: AllSectionsDTO) {
        self.sections = dto.sections.compactMap { SectionEntity(dto: $0)}
    }
}

extension SectionEntity {
    init(dto: SectionDTO) {
        self.name = dto.name
        self.type = dto.type
        self.contentType = dto.contentType
        self.order = dto.order
        self.content = dto.content.map { ContentEntity(dto: $0) }
    }
}

extension ContentEntity {
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
        self.podcastID = dto.podcastID
        self.name = dto.name
        self.description = dto.description
        self.avatarURL = dto.avatarURL
        self.episodeCount = dto.episodeCount
        self.duration = dto.duration
        self.language = dto.language
        self.priority = dto.priority
        self.popularityScore = dto.popularityScore
        self.score = dto.score
    }
}

extension EpisodeEntity {
    init(dto: EpisodeDTO) {
        self.podcastPopularityScore = dto.podcastPopularityScore
        self.podcastPriority = dto.podcastPriority
        self.episodeID = dto.episodeID
        self.name = dto.name
        self.seasonNumber = dto.seasonNumber
        self.episodeType = dto.episodeType
        self.podcastName = dto.podcastName
        self.authorName = dto.authorName
        self.description = dto.description
        self.number = dto.number
        self.duration = dto.duration
        self.avatarURL = dto.avatarURL
        self.separatedAudioURL = dto.separatedAudioURL
        self.audioURL = dto.audioURL
        self.releaseDate = dto.releaseDate
        self.podcastID = dto.podcastID
        self.chapters = dto.chapters
        self.paidIsEarlyAccess = dto.paidIsEarlyAccess
        self.paidIsNowEarlyAccess = dto.paidIsNowEarlyAccess
        self.paidIsExclusive = dto.paidIsExclusive
        self.paidTranscriptURL = dto.paidTranscriptURL
        self.freeTranscriptURL = dto.freeTranscriptURL
        self.paidIsExclusivePartially = dto.paidIsExclusivePartially
        self.paidExclusiveStartTime = dto.paidExclusiveStartTime
        self.paidEarlyAccessDate = dto.paidEarlyAccessDate
        self.paidEarlyAccessAudioURL = dto.paidEarlyAccessAudioURL
        self.paidExclusivityType = dto.paidExclusivityType
        self.score = dto.score
    }
}

extension AudiobookEntity {
    init(dto: AudiobookDTO) {
        self.audiobookID = dto.audiobookID
        self.name = dto.name
        self.authorName = dto.authorName
        self.description = dto.description
        self.avatarURL = dto.avatarURL
        self.duration = dto.duration
        self.language = dto.language
        self.releaseDate = dto.releaseDate
        self.score = dto.score
    }
}

extension AudioArticleEntity {
    init(dto: AudioArticleDTO) {
        self.articleID = dto.articleID
        self.name = dto.name
        self.authorName = dto.authorName
        self.description = dto.description
        self.avatarURL = dto.avatarURL
        self.duration = dto.duration
        self.releaseDate = dto.releaseDate
        self.score = dto.score
    }
}
