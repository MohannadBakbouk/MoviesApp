//
//  SerachParams.swift
//  MoviesApp
//
//  Created by Mohannad on 29/01/2024.
//

struct SearchParams {
    var page : Int
    var query : String?
    var pages: Int
    var lang: String
    
    init(query : String? = nil , page : Int = 1, pages: Int = 0, lang : String = "en-US") {
        self.query = query
        self.page = page
        self.pages = pages
        self.lang = lang
    }
    
    var canLoadMore: Bool{
        return page < pages
    }
}

extension SearchParams {
    var  asJson: JSON {
        var info: JSON = ["page" : page , "language" : lang]
        _ =  query != nil ?  info["without_keywords"] =  query! : ()
        return info
    }
}

