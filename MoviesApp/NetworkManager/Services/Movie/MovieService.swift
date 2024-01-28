//
//  MovieService.swift
//  MoviesApp
//
//  Created by Mohannad on 28/01/2024.
//

import Combine

protocol MovieServiceProtocol {
    func discoverMovies(info: SearchParams) -> AnyPublisher<DiscoverMoviesResponse, NetworkError>
    func getMovieDetails(id: Int) -> AnyPublisher<MovieDetailsResponse, NetworkError>
}

final class MovieService: MovieServiceProtocol {
    let networkManager : NetworkManagerProtocol
    
    init(networkManager : NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func discoverMovies(info: SearchParams) -> AnyPublisher<DiscoverMoviesResponse , NetworkError>{
        return networkManager.request(endpoint: MovieEndpoint.discoverMovies(info: info))
    }
    func getMovieDetails(id: Int) -> AnyPublisher<MovieDetailsResponse , NetworkError>{
        return networkManager.request(endpoint: MovieEndpoint.detailsMovie(id: id))
    }
    
}
