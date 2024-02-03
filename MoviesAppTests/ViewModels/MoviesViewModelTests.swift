//
//  MoviesViewModelTests.swift
//  MoviesAppTests
//
//  Created by Mohannad on 28/01/2024.
//

import XCTest
import Combine
@testable import MoviesApp

final class MoviesViewModelTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    var viewModel: MoviesViewModelProtocol!
    
    override func setUpWithError() throws {
        viewModel = MoviesViewModel(service: MockedMovieService())
        cancellables = []
    }

    override func tearDownWithError() throws {
        viewModel = nil
        cancellables = []
    }
    
    func testAreMoviesPublished() throws {
        let expectation = expectation(description: "Testing the feteched movies are published to view ")
        var movies : [MovieViewData] = []
        viewModel.movies.sink { completed in
            expectation.fulfill()
        } receiveValue: { items in
            movies.append(contentsOf: items)
        }.store(in: &cancellables)
        
        viewModel.loadMovies() // trigger
        _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssert(movies.count > 10 , "Failed to publish the fetched movies")
    }
    
    func testIsLoadingSignalPublished() throws {
        let expectation = expectation(description: "Testing the isLoading signal of load movies")
        var received : [Bool] = [] , expected = [true , false]
        viewModel.isLoading.sink { completed in
            expectation.fulfill()
        } receiveValue: { value in
            received.append(value)
        }.store(in: &cancellables)
        
        viewModel.loadMovies()
        
        _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssert(received == expected, "Failed to publish isLoading signal")
    }
    
    func testIsErrorPublished() throws {
        let expectation = expectation(description: "Testing the error is published")
        let error = PassthroughSubject<ErrorDataView? , Never>()
        var received: String?
        
        error.assign(to: \.value , on : viewModel.error)
        .store(in: &cancellables)
        
        viewModel.error.sink { completed in
            expectation.fulfill()
        } receiveValue: { value in
            received = value?.message
        }.store(in: &cancellables)
        
        error.send(ErrorDataView(with: .internetOffline))
        
        _ = XCTWaiter.wait(for: [expectation], timeout: 5)
         XCTAssert(received == NetworkError.internetOffline.message ,  "Failed to publish error message")
    }
    
    func testIsLoadingMoreSignalPublished() throws {
        let expect1 = XCTestExpectation(description: "")
        let expect2 = XCTestExpectation(description: "Testing the IsLoadingMore signal of pagination")
       
        var received : [Bool] = [] , expected = [false, true, false]
        viewModel.isLoadingMore
        .removeDuplicates()
        .sink { completed in
            _ = received.count == 3 ? expect2.fulfill() : ()
        } receiveValue: { value in
            received.append(value)
        }.store(in: &cancellables)
        
        viewModel.loadMovies()
        _ = XCTWaiter.wait(for: [expect1], timeout: 5)
        
        viewModel.reachedBottomTrigger.send() // trigger
        _ = XCTWaiter.wait(for: [expect2], timeout: 5)
        
        XCTAssert(received == expected, "Failed to publish IsLoadingMore signal")
    }
    
    func testIsFetchingMoreWhenTheUserScrollDown() throws {
        let expect1 = XCTestExpectation(description: "")
        let expect2 = XCTestExpectation(description: "Testing the loading new page of movies")
       
        var movies : [MovieViewData] = []
          viewModel.movies
          .sink{ completed in
              _ = movies.count == 40 ? expect2.fulfill() : ()
           }
           receiveValue: { items in
               movies = items
           }.store(in: &cancellables)
        
         viewModel.loadMovies()
        _ = XCTWaiter.wait(for: [expect1], timeout: 5)
        
        viewModel.reachedBottomTrigger.send() // trigger
        _ = XCTWaiter.wait(for: [expect2], timeout: 5)
        
        XCTAssert(movies.count == 40, "Failed to publish a new page of movies")
    }

}
