//
//  SearchUITest.swift
//  PodcastApp
//
//  Created by Abrar on 17/10/2025.
//

import XCTest

final class SearchUITest: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func testSearch() throws {
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.exists, "Tab Bar should be present on launch.")

        let searchTabButton = tabBar.buttons.element(boundBy: 1)

        let exists = searchTabButton.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "The Search Tab button (Index 1) did not appear in time.")

        searchTabButton.tap()

        let searchField = app.searchFields["Search..."]
        XCTAssertTrue(searchField.waitForExistence(timeout: 2), "Failed to navigate to SearchView or find its search field.")
    }
}
