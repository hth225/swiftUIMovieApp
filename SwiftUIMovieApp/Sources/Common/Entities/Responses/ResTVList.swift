//
//  ResTVList.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 4/3/24.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let resTVList = try? JSONDecoder().decode(ResTVList.self, from: jsonData)

import Foundation

// MARK: - ResTVList
struct ResTVList: Codable {
    let page: Int
    let results: [ResTV]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
