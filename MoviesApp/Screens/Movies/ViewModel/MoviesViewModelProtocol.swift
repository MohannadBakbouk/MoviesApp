//
//  MoviesViewModelProtocol.swift
//  MoviesApp
//
//  Created by Mohannad on 30/01/2024.
//

import Foundation
import  Combine

protocol MoviesViewModelProtocol: BaseViewModelProtocol{
    var movies: CurrentValueSubject<[MovieViewData], Never>{get}
    var movieParams: SearchParams {get}
}
