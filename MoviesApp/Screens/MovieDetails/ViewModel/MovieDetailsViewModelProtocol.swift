//
//  MovieDetailsViewModelProtocol.swift
//  MoviesApp
//
//  Created by Mohannad on 01/02/2024.
//

import Foundation
import  Combine

protocol MovieDetailsViewModelProtocol: BaseViewModelProtocol{
    var details: CurrentValueSubject<MovieDetailsViewData?, Never>{get}
    func loadMovieDetails()
}
