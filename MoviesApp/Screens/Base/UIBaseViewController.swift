//
//  UIBaseViewController.swift
//  MoviesApp
//
//  Created by Mohannad on 30/01/2024.
//

import UIKit
import Combine

class UIBaseViewController<VM: BaseViewModelProtocol>: UIViewController {
    var cancellables: Set<AnyCancellable>
    weak var coordinator: Coordinator?
    let viewModel: VM!
    
    init(viewModel: VM!, coordinator: Coordinator?) {
        self.cancellables = []
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
