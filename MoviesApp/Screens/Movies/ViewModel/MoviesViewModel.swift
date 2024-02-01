//
//  MoviesViewModel.swift
//  MoviesApp
//
//  Created by Mohannad on 30/01/2024.
//

import Foundation
import Combine

final class MoviesViewModel: MoviesViewModelProtocol{
    var cancellables: Set<AnyCancellable>
    var isLoading: PassthroughSubject<Bool, Never>
    var error: CurrentValueSubject<ErrorDataView?, Never>
    var service: MovieServiceProtocol
    var movies: CurrentValueSubject<[MovieViewData], Never>
    var movieParams: SearchParams
    
    init(service: MovieServiceProtocol) {
        self.cancellables = []
        self.isLoading = PassthroughSubject()
        self.error = CurrentValueSubject(nil)
        self.movies = CurrentValueSubject([])
        self.movieParams = SearchParams()
        self.service = service
    }
    
    func loadMovies(){
           isLoading.send(true)
           service.discoverMovies(info: movieParams)
            .delay(for: 3, scheduler: RunLoop.main)
            .sink(receiveCompletion: {[weak self] completed in
               guard case .failure(let error) = completed else {return}
               self?.isLoading.send(false)
                self?.error.send(ErrorDataView(with: error))
           }, receiveValue: {[weak self] data in
               self?.isLoading.send(false)
               self?.movies.send(data.results.map{MovieViewData(info: $0)})
               self?.movieParams.pages = data.totalPages
               self?.movieParams.page = data.page
           }).store(in: &cancellables)
    }
}
