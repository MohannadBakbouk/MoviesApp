//
//  UIMoviesController.swift
//  MoviesApp
//
//  Created by Mohannad on 29/01/2024.
//

import UIKit

class UIMoviesController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryColor
        // Do any additional setup after loading the view.
        
//        MovieService().discoverMovies(info: SearchParams(query: "action", page: 5)).sink(receiveCompletion: { completed in
//            guard case .failure(let error) = completed else {return}
//            print(error)
//        }, receiveValue: { res in
//            print(res.results.count)
//        }).store(in: &cancellables)
//        
//        MovieService().getMovieDetails(id: 572802).sink(receiveCompletion: { completed in
//            guard case .failure(let error) = completed else {return}
//            print(error)
//        }, receiveValue: { res in
//            print(res.id)
//        }).store(in: &cancellables)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
