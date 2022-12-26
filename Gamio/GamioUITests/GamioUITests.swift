//
//  GamioUITests.swift
//  GamioUITests
//
//  Created by Gokberk Ozcan on 7.12.2022.
//

import XCTest

final class GamioUITests: XCTestCase {
    private var app: XCUIApplication!
       
       override func setUp() {
           super.setUp()
           continueAfterFailure = false
       }



    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLanguageChange() throws {
        let app = XCUIApplication()
        app.launch()
        let languageButton = app.buttons["english"] // This text should change according to the currently selected language of app. (turkiye,english)
        XCTAssert(languageButton.exists)
        languageButton.tap()
        
        let tableViewRow = app.tables.staticTexts["Turkish"] // This text should change according to the currently selected language of app. (Turkish, English)
        XCTAssert(tableViewRow.exists)
        tableViewRow.tap()

    }
   
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
extension XCUIApplication {
    // MARK: - Game Lis View Controller

    
    var languageButton: XCUIElement! {
        buttons["languageButton"]
    }
    
    var isLanguageButtonDisplayed: Bool {
        languageButton.exists
    }

}
