//
//  Constants.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 2024/03/13.
//

import Foundation

struct Constants {
    static let imageURL = "https://image.tmdb.org/t/p"
    static let baseAPIURL = "https://api.themoviedb.org/3"
    static let popluarMovieURL = "/movie/popular"
    static func movieDetailURL(movieID: Int) -> String { "/movie/\(movieID)" }
    static func tvShowDetailURL(showID: Int) -> String { "/tv/\(showID)" }
    static let popluarTVURL = "/tv/popular"
    static let apiKey = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1YjYzY2M5ODc4ZDc5Yjc3NjgxMGI0YzliODVlZTYxNSIsInN1YiI6IjViOWI1ZWNlYzNhMzY4NmMwZTAwZjJlNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.bv0YULevsT3--HxQGrgf5lABOU9B1jaDsxqyzStd-bI"
}
