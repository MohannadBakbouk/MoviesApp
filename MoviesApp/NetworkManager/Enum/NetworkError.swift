//
//  NetworkError.swift
//  MoviesApp
//
//  Created by Mohannad on 28/01/2024.
//

import Foundation

enum NetworkError: Int,  Error {
    case unAuthorized
    case forbidden
    case notFound
    case server
    case parse
    case invalidUrl
    case internetOffline
    case invalidHostname
    case errorOccured
    
    var message : String {
        switch self {
            case .internetOffline:  return ErrorMessages.internet
            case .server: return ErrorMessages.server
            case .errorOccured: return ErrorMessages.general
            case .parse: return ErrorMessages.parsing
            case .notFound : return ErrorMessages.notFound
            case .invalidHostname: return ErrorMessages.hostNameNotFound
            default: return ErrorMessages.anInternal
        }
    }
    
    static func convert(_ error : Error?) -> NetworkError{
        guard error as? NetworkError == nil else {return error as! NetworkError}
        guard let mapped = error as? URLError else {
            return .errorOccured
            
        }
        switch mapped.code {
          case .notConnectedToInternet : return .internetOffline
          case .timedOut: return .internetOffline
          case .cannotDecodeContentData: return .parse
          case .cannotDecodeRawData: return .parse
          case .appTransportSecurityRequiresSecureConnection: return .invalidUrl
          case .unsupportedURL: return .invalidUrl
          case .cannotFindHost : return .invalidHostname
          default: return .errorOccured
        }
    }
    
    static func convert(_ code : Int?) -> NetworkError?{
        return code == 401 ? .unAuthorized : code == 403 ? .forbidden : code == 404 ? .notFound :  code == 500 ? .server : nil
    }
}
