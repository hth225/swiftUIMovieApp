//
//  ReqMovieDetail.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 3/29/24.
//

import Foundation

// MARK: - ReqMovieDetail
struct ReqMovieDetail {
    let movieID: Int
    let language: String?
    
    init(movieID: Int, language: String?) {
        self.movieID = movieID
        self.language = language
    }
}
