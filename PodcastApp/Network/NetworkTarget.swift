//
//  NetworkTarget.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

import Foundation

protocol NetworkTarget {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethodType { get }
    var headers: [String: String]? { get }
}

extension NetworkTarget {
    var headers: [String: String]? { nil }
}
