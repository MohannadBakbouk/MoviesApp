//
//  Endpoint.swift
//  MoviesApp
//
//  Created by Mohannad on 28/01/2024.
//

import Foundation
protocol Endpoint{
    var path: String{get}
    var url: String{get}
    var params: JSON {get}
    var authKey: JSON{get}
    var method: Method{get}
}

extension Endpoint{
    var authKey:JSON {
        return ["api_key": ApiInfo.key]
    }
    
    var url: String {"\(ApiInfo.baseUrl)\(path)"}
}

