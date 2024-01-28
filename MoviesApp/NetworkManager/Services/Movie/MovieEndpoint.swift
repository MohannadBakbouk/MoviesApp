//
//  MovieEndpoint.swift
//  MoviesApp
//
//  Created by Mohannad on 28/01/2024.
//

import Foundation

enum MovieEndpoint: Endpoint{
    case discoverMovies(info: SearchParams)
    case detailsMovie(id: Int)
    
    var path: String{
        switch self {
          case .discoverMovies:       "discover/movie"
          case .detailsMovie(let id): "movie/\(id)"
        }
    }
    
    var params: JSON{
        switch self {
        case .discoverMovies(let info):
            var params = info.asJson
            params.merge(dict: authKey)
            return params
        case .detailsMovie(let id):
            return authKey
        }
    }
    
    var method: Method{
        return .Get
    }
}
