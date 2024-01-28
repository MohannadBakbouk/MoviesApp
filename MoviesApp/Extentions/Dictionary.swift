//
//  Dictionary.swift
//  MoviesApp
//
//  Created by Mohannad on 28/01/2024.
//

import Foundation

extension Dictionary {
    var asData: Data?{
        let json = try? JSONSerialization.data(withJSONObject: self)
        return json
    }
    
    var asQueryItems: [URLQueryItem]{
        self.map{URLQueryItem(name: String(describing: $0.key), value: String(describing: $0.value))}
    }
    
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
