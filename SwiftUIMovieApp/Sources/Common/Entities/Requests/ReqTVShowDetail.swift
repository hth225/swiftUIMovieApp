//
//  ReqTVShowDetail.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 4/5/24.
//

import Foundation

// MARK: - ReqTVShowDetail
struct ReqTVShowDetail {
    let showID: Int
    let language: String?
    
    init(showID: Int, language: String?) {
        self.showID = showID
        self.language = language
    }
}
