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
}
