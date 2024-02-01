//
//  UIMovieDetailsController.swift
//  MoviesApp
//
//  Created by Mohannad on 01/02/2024.
//

import UIKit

final class UIMovieDetailsController: UIBaseViewController<MovieDetailsViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.loadMovieDetails()
    }
    
    private func setupViews(){
        view.backgroundColor = .primaryColor
        setupViewsConstraints()
    }
    
    private func setupViewsConstraints(){
        
    }
}
