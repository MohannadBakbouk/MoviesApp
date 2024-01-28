//
//  DiscoverMoviesResponse.swift
//  MoviesApp
//
//  Created by Mohannad on 28/01/2024.
//

import Foundation

// MARK: - Moives
struct DiscoverMoviesResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
