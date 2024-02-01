//
//  Collection.swift
//  MoviesApp
//
//  Created by Mohannad on 01/02/2024.
//

import Foundation
extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
