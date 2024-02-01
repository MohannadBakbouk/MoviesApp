//
//  MovieViewData.swift
//  MoviesApp
//
//  Created by Mohannad on 31/01/2024.
//

import Foundation

struct MovieViewData {
    let id: Int
    let title: String
    let overview: String
    let year: Int
    let rating: Double
    let ratingCount: String
    let popularity: String
    let image: URL?
}

extension MovieViewData {
     init(info: Movie) {
         self.id = info.id
         self.title = info.originalTitle
         self.overview = info.overview
         self.year = info.releaseDate.toDate?.year ?? Date().year
         self.rating = info.voteAverage
         self.ratingCount = " (\(info.voteCount)) "
         self.popularity = String(format: "%.0f", floor(info.popularity))
         self.image = "\(ApiInfo.imagesUrl)\(info.posterPath)".asURL()
    }
}
