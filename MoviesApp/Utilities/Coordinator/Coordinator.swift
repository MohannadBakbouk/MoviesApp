//
//  Coordinator.swift
//  MoviesApp
//
//  Created by Mohannad on 29/01/2024.
//

import UIKit

protocol Coordinator: AnyObject {
    var  childCoordinators : [Coordinator] {get set}
    var  navigationController : UINavigationController {get set}
    func start()
    func back()
    func dismiss()
}
