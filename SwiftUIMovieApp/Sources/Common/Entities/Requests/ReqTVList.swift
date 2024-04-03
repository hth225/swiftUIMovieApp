//
//  ReqTVList.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 3/20/24.
//

import Foundation

struct ReqTVList {
    let page: Int
    let language: String
    
    init(page: Int, language: String?) {
        self.page = page
        self.language = language ?? "en-US"
    }
}
