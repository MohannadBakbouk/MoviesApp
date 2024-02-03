//
//  SplashUITests.swift
//  MoviesAppUITests
//
//  Created by Mohannad on 28/01/2024.
//

import XCTest

final class SplashUITests: XCTestCase {
    var app = XCUIApplication()
    
    override func setUpWithError() throws {
        app.launchArguments = ["-uitesting"]
    }

    override func tearDownWithError() throws {
        app.terminate()
    }

    func testIsIndicatorShown() throws {
        app.launch()
        XCTAssert(app.activityIndicators["InidicatorView"].exists)
    }
    
    func testIsSlugShown() throws{
        app.launch()
        XCTAssert(app.staticTexts["SlugLabel"].exists)
    }
}
