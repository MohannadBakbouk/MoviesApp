//
//  UINavigationController.swift
//  MoviesApp
//
//  Created by Mohannad on 29/01/2024.
//

import UIKit

extension UINavigationController{
    convenience init(hideBar : Bool){
        self.init()
        navigationBar.isHidden = hideBar
    }
}

