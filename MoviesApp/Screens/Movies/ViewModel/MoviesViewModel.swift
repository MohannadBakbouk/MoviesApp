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
    
    init(service: MovieServiceProtocol) {
        self.cancellables = []
        self.isLoading = PassthroughSubject()
        self.error = CurrentValueSubject(nil)
        self.service = service
    }
}
