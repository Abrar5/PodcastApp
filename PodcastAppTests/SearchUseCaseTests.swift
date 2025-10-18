//
//  SearchUseCaseTests.swift
//  PodcastApp
//
//  Created by Abrar on 17/10/2025.
//

import XCTest
@testable import PodcastApp

final class SearchUseCaseTests: XCTestCase {
    var sut: SearchUseCase!
    var viewModel: SearchViewModel!

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        viewModel = nil
    }
    
    func testSearch_success() async {
        let expect = XCTestExpectation(description: "Search Use Case_success")
        do {
            sut = SearchUseCase(query: "Intelligence")
            let result = try await sut.execute()
            XCTAssertNotNil(result)
        } catch {
            XCTFail("No Search Result")
            XCTAssertNil(error.localizedDescription)
        }
        expect.fulfill()
    }
    
    @MainActor func testSearch() {
        let expect = XCTestExpectation(description: "Search Use Case")
        viewModel = SearchViewModel()
        let result: () = viewModel.search(query: "Intelligence")
        XCTAssertNotNil(result)
        expect.fulfill()
    }
    
    @MainActor
    func testUpdateSearchLoadingState_empty() {
        let expect = XCTestExpectation(description: "Test Update Search Loading State - empty")
        viewModel = SearchViewModel()
        let result = viewModel.updateSearchLoadingState([])
        XCTAssertEqual(result, .empty)
        expect.fulfill()
    }
    
    @MainActor
    func testUpdateSearchLoadingState_done() {
        let expect = XCTestExpectation(description: "Test Update Search Loading State - done")
        viewModel = SearchViewModel()
        
        let dto = StubGenerator().stubSearchSections(query: "Artificial")
        XCTAssertNotNil(dto)
        let entity = SearchEntity(dto: dto)
        XCTAssertNotNil(entity)
        
        let result = viewModel.updateSearchLoadingState(entity.sections ?? [])
        XCTAssertEqual(result, .done)

        expect.fulfill()
    }
    
    @MainActor
    func testUpdateErrorIndicatorLoadingState_none() {
        let expect = XCTestExpectation(description: "Test Update Error Search Loading State - none")
        viewModel = SearchViewModel()
        let result = viewModel.updateErrorIndicatorLoadingState(shouldGetSearchResults: true)
        XCTAssertEqual(result, .none)
        expect.fulfill()
    }
    
    @MainActor
    func testUpdateErrorIndicatorLoadingState_error() {
        let expect = XCTestExpectation(description: "Test Update Error Search Loading State - error")
        viewModel = SearchViewModel()
        let result = viewModel.updateErrorIndicatorLoadingState(shouldGetSearchResults: false)
        XCTAssertEqual(result, .error)
        expect.fulfill()
    }
    
}
