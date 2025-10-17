//
//  SearchMapper.swift
//  PodcastApp
//
//  Created by Abrar on 16/10/2025.
//

extension SearchEntity {
    init(dto: SearchDTO) {
        self.sections = dto.sections?.compactMap { SearchSectionEntity(dto: $0)}
    }
}

extension SearchSectionEntity {
    init(dto: SearchSectionDTO) {
        self.name = dto.name
        self.type = dto.type
        self.contentType = dto.contentType
        self.order = dto.order
        self.content = dto.content?.map { SearchContentEntity(dto: $0) } ?? []
    }
}

extension SearchContentEntity {
    init(dto: SearchContentDTO) {
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
