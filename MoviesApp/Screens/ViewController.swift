//
//  ViewController.swift
//  MoviesApp
//
//  Created by Mohannad on 28/01/2024.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        MovieService().discoverMovies(info: SearchParams(query: "action", page: 5)).sink(receiveCompletion: { completed in
            guard case .failure(let error) = completed else {return}
            print(error)
        }, receiveValue: { res in
            print(res.results.count)
        }).store(in: &cancellables)
        
        MovieService().getMovieDetails(id: 572802).sink(receiveCompletion: { completed in
            guard case .failure(let error) = completed else {return}
            print(error)
        }, receiveValue: { res in
            print(res.id)
        }).store(in: &cancellables)
    }


}

