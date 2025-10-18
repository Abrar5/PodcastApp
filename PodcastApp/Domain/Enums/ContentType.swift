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
