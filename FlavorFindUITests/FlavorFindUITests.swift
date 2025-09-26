//
//  FlavorFindUITests.swift
//  FlavorFindUITests
//
//  Created by Daniel Pratt on 9/20/25.
//

import XCTest

final class FlavorFindUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
    
    @MainActor
    func testNavigationToDetailView() {
        let app = XCUIApplication()
        app.activate()
        app/*@START_MENU_TOKEN@*/.staticTexts["Tandoori chicken"]/*[[".otherElements.staticTexts[\"Tandoori chicken\"]",".staticTexts[\"Tandoori chicken\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        
        let ingredientsHeader = app.navigationBars["Tandoori chicken"]
        XCTAssertTrue(ingredientsHeader.waitForExistence(timeout: 5))
    }
    
    @MainActor
    func testAddRecipeSheetOpens() {
        let app = XCUIApplication()
        app.activate()
        app/*@START_MENU_TOKEN@*/.buttons["Add Recipe"]/*[[".navigationBars.buttons[\"Add Recipe\"]",".buttons[\"Add Recipe\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        
        let addRecipeHeader = app.staticTexts["Recipe Info"]
        XCTAssertTrue(addRecipeHeader.waitForExistence(timeout: 5))
    }
}
