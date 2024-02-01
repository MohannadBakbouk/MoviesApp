//
//  MainCoordinator.swift
//  MoviesApp
//
//  Created by Mohannad on 29/01/2024.
//

import UIKit

final class MainCoordinator: Coordinator{
    
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    init(navigation : UINavigationController) {
        childCoordinators = []
        navigationController = navigation
    }
    
    func start() {
        let splash = UISplashController()
        splash.coordinator = self
        pushViewControllerToStack(with: splash)
    }
    
    func showMovies(){
        let viewModel = MoviesViewModel(service: MovieService())
        let moviesScreen = UIMoviesController(viewModel:viewModel, coordinator: self)
        pushViewControllerToStack(with:moviesScreen, animated: false, isRoot: true)
    }
    
    func showMovieDetails(with info: MovieViewData){
        let viewModel = MovieDetailsViewModel(service: MovieService(), movieInfo: info)
        let detailsScreen = UIMovieDetailsController(viewModel:viewModel, coordinator: self)
        pushViewControllerToStack(with:detailsScreen, animated: true, isRoot: false)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
}

extension MainCoordinator {
    func pushViewControllerToStack(with value : UIViewController , animated : Bool = true ,  isRoot: Bool = false){
        _ = isRoot ? navigationController.setViewControllers([], animated: false) : ()
        navigationController.pushViewController(value, animated: animated)
    }
}
