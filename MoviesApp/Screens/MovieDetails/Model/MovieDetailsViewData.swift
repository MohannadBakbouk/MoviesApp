//
//  MovieDetailsViewData.swift
//  MoviesApp
//
//  Created by Mohannad on 01/02/2024.
//

import Foundation

struct MovieDetailsViewData {
    let id: Int
    let title: String
    let overview: String
    let year: Int
    let rating: Double
    let ratingCount: String
    let popularity: String
    let image: URL?
    let category, status: String
    let revenue, runtime: String

}

extension MovieDetailsViewData {
     init(info: MovieDetailsResponse) {
         self.id = info.id
         self.title = info.originalTitle
         self.overview = info.overview
         self.year = info.releaseDate.toDate?.year ?? Date().year
         self.rating = info.voteAverage
         self.ratingCount = " (\(info.voteCount)) "
         self.popularity = String(format: "%.0f", floor(info.popularity))
         self.image = "\(ApiInfo.imagesUrl)\(info.posterPath)".asURL()
         self.category = info.genres.map{$0.name}.joined(separator: ",")
         self.status = info.status
         self.runtime = "\(info.runtime)"
         self.revenue = "\(info.revenue)"
    }
}
