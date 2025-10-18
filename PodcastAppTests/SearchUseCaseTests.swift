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
}
