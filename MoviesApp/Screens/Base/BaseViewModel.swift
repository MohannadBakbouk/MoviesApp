//
//  BaseViewModel.swift
//  MoviesApp
//
//  Created by Mohannad on 30/01/2024.
//

import Foundation
import Combine

protocol BaseViewModelProtocol  {
    var cancellables: Set<AnyCancellable> {get}
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var error: CurrentValueSubject<ErrorDataView?, Never> {get}
}

class BaseViewModel: BaseViewModelProtocol{
    var cancellables: Set<AnyCancellable>
    var isLoading: PassthroughSubject<Bool, Never>
    var error: CurrentValueSubject<ErrorDataView?, Never>
    
    
    init() {
        self.cancellables = []
        self.isLoading = PassthroughSubject()
        self.error = CurrentValueSubject(nil)
    }
}
