//
//  UIView.swift
//  MoviesApp
//
//  Created by Mohannad on 29/01/2024.
//

import UIKit

extension UIView {
    func addSubviews(contentOf items: [UIView]){
        _ = items.map{addSubview($0)}
    }
}
