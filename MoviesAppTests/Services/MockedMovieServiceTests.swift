//
//  MockedMovieServiceTests.swift
//  MoviesAppTests
//
//  Created by Mohannad on 02/02/2024.
//

import XCTest
import Combine
@testable import MoviesApp

final class MockedMovieServiceTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    var service: MovieServiceProtocol!
    
    override func setUpWithError() throws {
       service = MockedMovieService()
       cancellables = []
    }

    override func tearDownWithError() throws {
       service = nil
       cancellables = []
    }

    func testDiscoverMovies() throws {
        let expectation = expectation(description: "feteching movies via the mocked api")
        var results : [Movie] = []
        service.discoverMovies(info: SearchParams())
        .sink {completed in
            expectation.fulfill()
        } receiveValue: { data in
            results.append(contentsOf: data.results)
        }.store(in: &cancellables)
        _ = XCTWaiter.wait(for: [expectation], timeout: 10)
        XCTAssert(results.count > 0  , "Failed to fetch movies via the mocked api")
    }
    
    func testGetMovieDetails(){
        let expectation = expectation(description: "feteching movie's details via the mocked api")
        var details: MovieDetailsResponse?
        service.getMovieDetails(id: 572802)
        .sink { completed in
            expectation.fulfill()
        } receiveValue: { info in
            details = info
        }.store(in: &cancellables)
        _ = XCTWaiter.wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(details, " Failed to fetch movie's details via the mocked api")
    }
}
