//
//  UIMovieDetailsController+BindingModel.swift
//  MoviesApp
//
//  Created by Mohannad on 02/02/2024.
//

import Foundation
import Combine

extension UIMovieDetailsController {
    func bindingDetailsToViews(){
        viewModel.details
        .receive(on: DispatchQueue.main)
        .sink {[weak self] info in
            guard let self = self else {return}
            self.tableView.reloadData()
            self.tableView.layoutIfNeeded()
            self.tableViewHeight.constraint.update(offset: self.tableView.contentSize.height)
        }.store(in: &cancellables)
    }
}
