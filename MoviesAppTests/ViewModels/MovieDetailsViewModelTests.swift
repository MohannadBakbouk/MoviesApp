//
//  MovieDetailsViewModelTests.swift
//  MoviesAppTests
//
//  Created by Mohannad on 03/02/2024.
//

import XCTest
import Combine
@testable import MoviesApp

final class MovieDetailsViewModelTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    var viewModel: MovieDetailsViewModelProtocol!
    var info: MovieViewData!
    
    override func setUpWithError() throws {
        info = MockedMovieService.dummyMovie
        viewModel = MovieDetailsViewModel(service: MockedMovieService(), movieInfo: info)
        cancellables = []
    }
    
    override func tearDownWithError() throws {
        info = nil
        viewModel = nil
        cancellables = []
    }
    
    func testAreMovieDetailsPublished() throws {
        let expectation = expectation(description: "Testing the feteched movie's details are published to view ")
        var movieDetails : MovieDetailsViewData?
       
        viewModel.details.sink { completed in
            expectation.fulfill()
        } receiveValue: { info in
            movieDetails = info
        }.store(in: &cancellables)
        
        viewModel.loadMovieDetails() // trigger
        _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        
        XCTAssertNotNil(movieDetails, "Failed to publish the movie's details")
    }
    
    func testAreMovieDetailsCorrect() throws {
        let expectation = expectation(description: "Testing the feteche movie's details are correct")
        var details : MovieDetailsViewData?
       
        viewModel.details.sink { completed in
            expectation.fulfill()
        } receiveValue: { info in
            details = info
        }.store(in: &cancellables)
        
        viewModel.loadMovieDetails() // trigger
        _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        
        let status = info.id == details?.id && info.title == details?.title && info.overview  == details?.overview
        
        XCTAssert(status, "Failed to publish the movie's details are incorrect")
    }
    
}
