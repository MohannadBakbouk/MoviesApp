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
    var reachedBottomTrigger: PassthroughSubject<Void, Never>
    var isLoadingMore: CurrentValueSubject<Bool, Never>
    var movieParams: SearchParams
    
    init(service: MovieServiceProtocol) {
        self.cancellables = []
        self.isLoading = PassthroughSubject()
        self.error = CurrentValueSubject(nil)
        self.movies = CurrentValueSubject([])
        self.reachedBottomTrigger = PassthroughSubject()
        self.isLoadingMore = CurrentValueSubject(false)
        self.movieParams = SearchParams()
        self.service = service
        subcribingReachedBottomTrigger()
    }
    
    func loadMovies(){
           _ = !isLoadingMore.value ? isLoading.send(true) : ()
           let delay: RunLoop.SchedulerTimeType.Stride = !isLoadingMore.value ? 3 : 0 // this delaytion  would allow the animation appear on the first time
           service.discoverMovies(info: movieParams)
           .delay(for: 0, scheduler: RunLoop.main)
           .sink(receiveCompletion: {[weak self] completed in
               guard case .failure(let error) = completed else {return}
                self?.isLoading.send(false)
                self?.error.send(ErrorDataView(with: error))
           }, receiveValue: {[weak self] data in
               self?.isLoading.send(false)
               self?.isLoadingMore.send(false)
               var movies = self?.movies.value ?? []
               movies.append(contentsOf: data.results.map{MovieViewData(info: $0)})
               self?.movies.send(movies)
               self?.movieParams.pages = data.totalPages
               self?.movieParams.page = data.page
           }).store(in: &cancellables)
    }

    func subcribingReachedBottomTrigger(){
        reachedBottomTrigger
        .filter{ [weak self] in
            guard let self = self else { return false}
            return self.movieParams.canLoadMore && !isLoadingMore.value
        }
        .sink{[weak self] _ in
            self?.movieParams.page += 1
            self?.isLoadingMore.send(true)
            self?.loadMovies()
        }.store(in: &cancellables)
    }
}
