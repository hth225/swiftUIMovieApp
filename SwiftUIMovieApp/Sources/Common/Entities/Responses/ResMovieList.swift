//
//  ResMovieList.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 3/19/24.
//

import Foundation

// MARK: - ResMovieList
struct ResMovieList: Codable {
    let page: Int
    let results: [ResMovie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
