//
//  MockedMovieService.swift
//  MoviesAppTests
//
//  Created by Mohannad on 02/02/2024.
//

import Foundation
import Combine
@testable import MoviesApp

final class MockedMovieService: MovieServiceProtocol{
    
    func discoverMovies(info: SearchParams) -> AnyPublisher<DiscoverMoviesResponse, NetworkError> {
        let bundle = Bundle(for: MockedMovieService.self)
        let resourceName = "MoviesPage1"
        guard let url = bundle.url(forResource: resourceName, withExtension: "json"),
              let data =  try? Data(contentsOf: url),
              let response = try? JSONDecoder().decode(DiscoverMoviesResponse.self, from: data) else {
            return AnyPublisher(Fail<DiscoverMoviesResponse, NetworkError>(error: .notFound))
        }
        return Result.Publisher(response).eraseToAnyPublisher()
    }
    
    func getMovieDetails(id: Int) -> AnyPublisher<MovieDetailsResponse, NetworkError> {
        let bundle = Bundle(for: MockedMovieService.self)
        let resourceName = "MovieDetails1"
        guard let url = bundle.url(forResource: resourceName, withExtension: "json"),
              let data =  try? Data(contentsOf: url),
              let response = try? JSONDecoder().decode(MovieDetailsResponse.self, from: data) else {
            return AnyPublisher(Fail<MovieDetailsResponse, NetworkError>(error: .notFound))
        }
        return Result.Publisher(response).eraseToAnyPublisher()
    }
}
