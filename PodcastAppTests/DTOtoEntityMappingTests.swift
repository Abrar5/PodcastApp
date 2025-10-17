//
//  DTOtoEntityMappingTests.swift
//  PodcastApp
//
//  Created by Abrar on 17/10/2025.
//

import XCTest
@testable import PodcastApp

final class DTOtoEntityMappingTests: XCTestCase {

    // MARK: - Home Sections
    func testHomeSectionsDtoToEntity() {
        let expect = XCTestExpectation(description: "Map Home Sections DTO to Entity")
        
        let dto = StubGenerator().stubHomeSections()
        XCTAssertNotNil(dto)
        
        let entity = AllSectionsEntity(dto: dto)
        XCTAssertNotNil(entity)

        XCTAssertEqual(dto.sections.count, entity.sections.count)
        expect.fulfill()
    }
    
    // MARK: - Search
    func testSearchDtoToEntity_success() {
        let expect = XCTestExpectation(description: "Map Search DTO to Entity")
        
        let query: String = "K"
        let dto = StubGenerator().stubSearchSections(query: query)
        XCTAssertNotNil(dto)
        
        let entity = SearchEntity(dto: dto)
        XCTAssertNotNil(entity)
        
        XCTAssertEqual(dto.sections?.count, entity.sections?.count)
        XCTAssertEqual(dto.sections?.first?.content?.count, entity.sections?.first?.content?.count)

        expect.fulfill()
    }
    
    func testSearchDtoToEntity_fail() {
        let expect = XCTestExpectation(description: "Map Search DTO to Entity")
        
        let query: String = "Home"
        XCTAssertNotNil(query)

        let dto = StubGenerator().stubSearchSections(query: query)
        XCTAssertNotNil(dto)
        
        let searchResult = SearchEntity(dto: dto).sections?.filter {
            $0.name?.lowercased().contains(query.lowercased()) ?? false
        }
        let entity = SearchEntity(sections: searchResult)
        XCTAssertEqual(entity.sections?.count, 0)

        expect.fulfill()
    }
}
