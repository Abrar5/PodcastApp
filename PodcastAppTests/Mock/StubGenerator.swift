//
//  StubGenerator.swift
//  PodcastApp
//
//  Created by Abrar on 17/10/2025.
//

import Foundation
@testable import PodcastApp

class StubGenerator {
    func stubHomeSections() -> AllSectionsDTO {
        guard let path = Bundle.main.path(forResource: "GetSections", ofType: "json") else {
            fatalError("GetSections.json not found in bundle.")
        }
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let sections = try! decoder.decode(AllSectionsDTO.self, from: data)
        return sections
    }
    
    func stubSearchSections(query: String) -> SearchDTO {
        guard let path = Bundle.main.path(forResource: "GetSearch", ofType: "json") else {
            fatalError("GetSearch.json not found in bundle.")
        }
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let sections = try! decoder.decode(SearchDTO.self, from: data)
        return sections
    }
}
