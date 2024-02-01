//
//  String.swift
//  MoviesApp
//
//  Created by Mohannad on 28/01/2024.
//

import Foundation

extension String {
    func asURL () -> URL?{
        return URL(string: self)
    }
    
    var toDate: Date? {
         let dateFormatter = DateFormatter()
         dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
         dateFormatter.dateFormat = "yyyy-MM-dd"
         return dateFormatter.date(from:self)
    }
}
