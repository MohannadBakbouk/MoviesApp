//
//  CustomXCTestCase.swift
//  MoviesAppUITests
//
//  Created by Mohannad on 03/02/2024.
//

import XCTest
import Swifter

enum Endpoint {
    static let discoverMovies = "/discover/movie"
    static let movieDetails = "/movie/*"
}

enum EndpointResponse {
    static let movies = "MoviesPage.json"
    static let details = "MovieDetails.json"
}

class CustomXCTestCase: XCTestCase {
    var app = XCUIApplication()
    let server = HttpServer()
  
    func setupNormalServer(){
        do {
            let path = try TestUtil.path(for: EndpointResponse.movies, in: type(of: self))
            server[Endpoint.discoverMovies] = shareFile(path)
            
            let path2 = try TestUtil.path(for: EndpointResponse.details, in: type(of: self))
            server[Endpoint.movieDetails] = shareFile(path2)
            
            try server.start()
        }catch {
            XCTAssert(false, "Swifter Server failed to start.")
        }
    }
    
    func switchToFailedServer(){
        server.stop()
        do {
            server[Endpoint.discoverMovies] = { _ in
               return HttpResponse.internalServerError
            }
            try server.start()
        }
        catch{
            XCTAssert(false, "Swifter Server failed to start.")
        }
    }
}


enum TestUtilError: Error {
    case fileNotFound
}

class TestUtil {
    static func path(for fileName: String, in bundleClass: AnyClass) throws -> String {
        if let path = Bundle(for: bundleClass).path(forResource: fileName, ofType: nil) {
            return path
        } else {
            throw TestUtilError.fileNotFound
        }
    }
}
