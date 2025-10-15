//
//  NetworkService.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

import Foundation

import Foundation

final class APIClient {
    static let shared = APIClient()
    
    private let session: URLSession
    
    private init() {
        let config = URLSessionConfiguration.default
        
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        config.waitsForConnectivity = true
        self.session = URLSession(configuration: config)
        
    }
    
    func request<T: Decodable>(_ target: NetworkTarget, responseType: T.Type) async throws -> T {
        
        
        let urlString = target.baseURL + target.path
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        print("✅ URL:", request)
        request.httpMethod = target.method.rawValue
        target.headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
      
        // Force HTTP/1.1 to avoid QUIC issues
        request.setValue("HTTP/1.1", forHTTPHeaderField: "Alt-Used")
        let (data, response) = try await session.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("✅ Status code:", httpResponse.statusCode)
            print("✅ Headers:", httpResponse.allHeaderFields)
        }
        
        let jsonString = String(data: data, encoding: .utf8) ?? "nil"
        print("✅ Raw response data:\n", jsonString)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("❌ Decoding failed for URL: \(urlString)")
            print("✅ JSON Response:\n\(jsonString)")
            throw error
        }
    }
    
    func fetchWithRetry<T: Decodable>(
        _ target: NetworkTarget,
        responseType: T.Type,
        retries: Int = 3,
        delaySeconds: Double = 2
    ) async throws -> T {
        var currentAttempt = 0
        while true {
            do {
                return try await APIClient.shared.request(target, responseType: responseType)
            } catch let error as URLError where error.code == .networkConnectionLost {
                currentAttempt += 1
                guard currentAttempt < retries else { throw error }
                print("❌ Network lost, retrying in \(delaySeconds) seconds... (Attempt \(currentAttempt))")
                try await Task.sleep(nanoseconds: UInt64(delaySeconds * 1_000_000_000))
            }
        }
    }
}
