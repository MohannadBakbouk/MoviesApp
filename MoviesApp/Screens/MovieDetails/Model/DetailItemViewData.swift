//
//  DetailItemViewData.swift
//  MoviesApp
//
//  Created by Mohannad on 02/02/2024.
//

import Foundation

enum DetailItem: Int, CaseIterable{
    case title = 0
    case overview
    case category
    case year
    case runTime
    case status
    case revenue
}

struct DetailItemViewData{
    let text: String
    let icon: String?
    let type: DetailItem
    
    init(_ text: String?, type: DetailItem){
        self.init(text, icon: nil, type: type)
    }
    
    init(_ text: String?, icon: String?, type: DetailItem) {
        self.text = text ?? ""
        self.icon = icon
        self.type = type
    }
}
