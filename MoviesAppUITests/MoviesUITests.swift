//
//  MoviesUITests.swift
//  MoviesAppUITests
//
//  Created by Mohannad on 03/02/2024.
//

import XCTest

private let collectionIdentifier = "MovieCollectionView"

final class MoviesUITests: CustomXCTestCase {

    override func setUpWithError() throws {
        app.launchArguments = ["-uitesting"]
        setupNormalServer()
        app.launch()
    }

    override func tearDownWithError() throws {
        server.stop()
        app.terminate()
    }

    func testIsNavigationBarHidden() throws {
       XCTAssert(app.navigationBars.count == 0)
    }
    
    func testAreMoviesShown() throws {
        XCTAssert(app.collectionViews[collectionIdentifier].waitForExistence(timeout: 5))
        _ = XCTWaiter.wait(for: [expectation(description: "Waiting for collectionView to end animation")], timeout: 5)
        XCTAssert(app.collectionViews[collectionIdentifier].cells.count > 0)
    }
    
    func testTappingOnMovieItemPresentDetailsScreen() throws {
         _ = app.collectionViews[collectionIdentifier].waitForExistence(timeout: 5)
        _ = XCTWaiter.wait(for: [expectation(description: "Waiting for collectionView to end animation")], timeout: 5)
        app.collectionViews[collectionIdentifier].cells.firstMatch.tap()
        XCTAssert(app.buttons["BackButton"].exists)
    }
    
    func testIsScrollWorking() throws {
        _ = app.collectionViews[collectionIdentifier].waitForExistence(timeout: 5)
        _ = XCTWaiter.wait(for: [expectation(description: "Waiting for collectionView to end animation")], timeout: 5)
        let targetCell = app.collectionViews[collectionIdentifier].cells.staticTexts["Lift"]
        var count = 0
        while targetCell.isHittable == false && count < 20 {
            app.swipeUp()
            count += 1
        }
        XCTAssert(targetCell.isHittable)
    }
    
    func testIsErrorShown(){
        switchToFailedServer()
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for collectionView to appear")], timeout: 10)
        let error = "an internal error occured in server side please try again later"
        XCTAssert(app.collectionViews[collectionIdentifier].exists)
        XCTAssert(app.collectionViews[collectionIdentifier].staticTexts[error].exists)
    }
}
