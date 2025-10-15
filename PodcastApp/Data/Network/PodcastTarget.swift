//
//  PodcastTarget.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

import Foundation

enum PodcastTarget: NetworkTarget {
    case homeSections
    case search(query: String)

    var baseURL: String {
        switch self {
            case .homeSections:
            return "https://api-v2-b2sit6oh3a-uc.a.run.app"
        case .search:
            return "https://mock.apidog.com/m1/735111-711675-default"
        }
    }

    var path: String {
        switch self {
        case .homeSections:
            return "/home_sections"
        case .search(query: let query):
            return "/search?q=\(query)"
        }
    }

    var method: HTTPMethodType {
        switch self {
        case .homeSections:
            return .get
        case .search:
            return .get
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .search(let query):
            return ["q": query]
        default:
            return nil
        }
    }
}
