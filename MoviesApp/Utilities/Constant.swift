//
//  Constant.swift
//  MoviesApp
//
//  Created by Mohannad on 28/01/2024.
//

import Foundation

enum ApiInfo {
    static let content = "application/json; charset=utf-8"
    static var baseUrl = "https://api.themoviedb.org/3/"
    static let imagesUrl = "https://image.tmdb.org/t/p/w500"
    static let localUrl = "http://localhost:8080/"
    static let key = "5a68758d4762171d54cf110856920623"
    static let format = "json"
}

enum ErrorMessages{
    static let  internet = "Please make sure you are connected to the internet"
    static let  server = "an internal error occured in server side please try again later"
    static let  general = "Something went wrong"
    static let  parsing = "an internal error occured while parsing the request please try again later"
    static let  anInternal = "an internal error occured"
    static let  notFound = "the url you have requested is not exited"
    static let  hostNameNotFound =  "the host you have requested is not existed"
}

enum Images {
    static let exclamationmark = "exclamationmark.circle.fill"
    static let star = "star"
    static let filledStar = "star.fill"
    static let halfFilledStar = "star.leadinghalf.fill"
    static let eye = "eye.fill"
    static let calendar = "calendar"
    static let dollar = "dollarsign.circle"
    static let bars = "line.horizontal.3.decrease.circle"
    static let camera = "camera.rotate"
    static let tag = "tag"
    static let back = "arrow.left.circle"
}
