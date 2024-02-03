//
//  MovieDetailsUITests.swift
//  MoviesAppUITests
//
//  Created by Mohannad on 03/02/2024.
//

import XCTest

private let collectionIdentifier = "MovieCollectionView"
private let tableIdentifier = "MovieCollectionView"

final class MovieDetailsUITests: CustomXCTestCase {

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
        navigateToDetails()
        XCTAssert(app.navigationBars.count == 0)
    }

    func testIsBackButtonShown() throws {
        navigateToDetails()
        XCTAssert(app.buttons["BackButton"].exists)
    }
    
    func testIsImageViewExists() throws {
        navigateToDetails()
        XCTAssert(app.images["MovieImageView"].exists)
    }
    
    func testIsTableDetailsExists() throws {
        navigateToDetails()
        XCTAssert(app.tables["DetailsTableView"].exists)
    }
    
    func testIsTitleCellShown() throws {
        navigateToDetails()
        XCTAssert(app.cells["title_cell"].exists)
    }
    
    func testIsOverviewCellShown() throws {
        navigateToDetails()
        XCTAssert(app.cells["overview_cell"].exists)
    }
    
    func testIsCategoryCellShown() throws {
        navigateToDetails()
        XCTAssert(app.cells["category_cell"].exists)
    }
    
    func testIsYearCellShown() throws {
        navigateToDetails()
        XCTAssert(app.cells["year_cell"].exists)
    }
    
    func testIsRatingCellShown() throws {
        navigateToDetails()
        XCTAssert(app.cells["rating_cell"].exists)
    }
    
    func testIsRunTimeCellShown() throws {
        navigateToDetails()
        XCTAssert(app.cells["runTime_cell"].exists)
    }
    
    func testIsStatusCellShown() throws {
        navigateToDetails()
        XCTAssert(app.cells["status_cell"].exists)
    }
    
    func testIsRevenueCellShown() throws {
        navigateToDetails()
        XCTAssert(app.cells["revenue_cell"].exists)
    }
    
    func testIsScrollWorking() throws {
        navigateToDetails()
        let revenue = "413.2M"
        XCTAssert(app.staticTexts[revenue].exists)
        app.swipeUp()
        XCTAssert(app.staticTexts[revenue].isHittable)
    }
}

extension MovieDetailsUITests {
    func navigateToDetails(){
        _ = app.collectionViews[collectionIdentifier].waitForExistence(timeout: 5)
        _ = XCTWaiter.wait(for: [expectation(description: "Waiting for collectionView to end animation")], timeout: 5)
        app.collectionViews[collectionIdentifier].cells.firstMatch.tap()
    }
}
