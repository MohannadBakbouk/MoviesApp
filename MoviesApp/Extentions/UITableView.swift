//
//  UITableView.swift
//  MoviesApp
//
//  Created by Mohannad on 02/02/2024.
//

import UIKit

extension UITableView{
    func register(_ cellClass: AnyClass){
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass.self))
    }

    func register(mutipleCells: [AnyClass]){
         _ = mutipleCells.map {register($0, forCellReuseIdentifier: String(describing: $0.self))}
    }

    func dequeueReusableCell(with cellClass: AnyClass, for indexPath: IndexPath) -> UITableViewCell?{
        dequeueReusableCell(withIdentifier: String(describing: cellClass.self), for: indexPath)
    }
}
