//
//  Date.swift
//  MoviesApp
//
//  Created by Mohannad on 01/02/2024.
//

import Foundation

extension Date {
    var year: Int{
        Calendar.current.component(.year, from: self)
    }
}
