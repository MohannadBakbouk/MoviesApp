//
//  ErrorDataView.swift
//  MoviesApp
//
//  Created by Mohannad on 30/01/2024.
//

import Foundation

struct ErrorDataView{
    var title : String
    var message : String
    var icon : String
}

extension ErrorDataView {
    init(message : String){
        self.init(title : "Error" , message : message , icon : Images.exclamationmark)
    }
    
    init (with error : NetworkError){
        self.init(title : "Error" , message : error.message , icon : Images.exclamationmark)
    }
}
