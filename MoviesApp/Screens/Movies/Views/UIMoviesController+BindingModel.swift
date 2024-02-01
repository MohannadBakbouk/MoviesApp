//
//  UIMoviesController+BindingModel.swift
//  MoviesApp
//
//  Created by Mohannad on 31/01/2024.
//

import Foundation
import Combine
import SkeletonView

extension UIMoviesController {
    func bindingMoviesToCollectionView(){
        viewModel.movies
        .receive(on: DispatchQueue.main)
        .sink {[weak self] items in
            self?.collectionViewLayout.invalidateLayout()
            self?.collectionView.reloadData()
        }.store(in: &cancellables)
    }
    
    func bindingIsLoadingToAnimator(){
        viewModel.isLoading
        .receive(on: DispatchQueue.main)
        .sink {[weak self] status in
            _  = status ? self?.collectionView.showAnimatedGradientSkeleton() : self?.stopSkeletonAnimation()
        }.store(in: &cancellables)
    }
    
    func bindingError(){
        viewModel.error
        .receive(on: DispatchQueue.main)
        .sink {[weak self] error in
            guard let error = error else {return}
            self?.stopSkeletonAnimation()
            self?.collectionView.setMessage(error.message)
        }.store(in: &cancellables)
    }
}
