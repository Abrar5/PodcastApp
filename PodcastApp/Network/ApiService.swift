//
//  ApiService.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

protocol ApiService {
    func request<T: Decodable>(_ endpoint: NetworkTarget, responseType: T.Type) async throws -> T
}
