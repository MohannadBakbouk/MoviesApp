//
//  MovieDetailsViewModel.swift
//  MoviesApp
//
//  Created by Mohannad on 01/02/2024.
//

import Foundation
import Combine

final class MovieDetailsViewModel: MovieDetailsViewModelProtocol{
    var details: CurrentValueSubject<MovieDetailsViewData?, Never>
    var cancellables: Set<AnyCancellable>
    var isLoading: PassthroughSubject<Bool, Never>
    var error: CurrentValueSubject<ErrorDataView?, Never>
    let service: MovieServiceProtocol
    let movieInfo: MovieViewData
    
    init(service: MovieServiceProtocol, movieInfo: MovieViewData) {
        self.cancellables = []
        self.isLoading = PassthroughSubject()
        self.error = CurrentValueSubject(nil)
        self.details = CurrentValueSubject(nil)
        self.service = service
        self.movieInfo = movieInfo
    }
    
    func loadMovieDetails(){
           isLoading.send(true)
        service.getMovieDetails(id: movieInfo.id)
           .delay(for: 3, scheduler: RunLoop.main)
           .sink(receiveCompletion: {[weak self] completed in
               guard case .failure(let error) = completed else {return}
                self?.isLoading.send(false)
                self?.error.send(ErrorDataView(with: error))
           }, receiveValue: {[weak self] data in
               self?.isLoading.send(false)
               self?.details.send(MovieDetailsViewData(info: data))
           }).store(in: &cancellables)
    }
}
