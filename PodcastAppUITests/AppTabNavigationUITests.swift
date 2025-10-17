//
//  AppTabNavigationUITests.swift
//  PodcastAppUITests
//
//  Created by Abrar on 14/10/2025.
//

import XCTest

final class AppTabNavigationUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testNavigateToHomeAndVerifyExistence() throws {
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.exists, "Tab Bar should be present on launch.")

        let homeTabButton = tabBar.buttons.element(boundBy: 0)

        let exists = homeTabButton.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "The Home Tab button (Index 0) did not appear in time.")

        homeTabButton.tap()
    }
    
    func testNavigateToSearchAndVerifyExistence() throws {
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
