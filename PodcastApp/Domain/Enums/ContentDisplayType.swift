//
//  ContentDisplayType.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

enum ContentDisplayType: String {
    case square
    case twoLinesGrid = "2_lines_grid"
    case bigSquare = "big square"
    case big_Square = "big_square"
    case queue
    case none
    
    init(from decoder: Decoder) throws {
        let rawValue = try decoder.singleValueContainer().decode(String.self)
        if let value = ContentDisplayType(rawValue: rawValue) {
            self = value
        } else {
            self = .none
            throw DecodingError.dataCorruptedError(
                in: try decoder.singleValueContainer(),
                debugDescription: "Invalid Content Display Type: \(rawValue)"
            )
        }
    }
}
