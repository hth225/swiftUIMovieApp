//
//  SimplifiedMovie.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 2024/03/13.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let simplifiedMovie = try? JSONDecoder().decode(SimplifiedMovie.self, from: jsonData)

import Foundation

// MARK: - SimplifiedMovie
struct SimplifiedMovie: Codable, Identifiable {
    let id: Int
    let posterPath, releaseDate, title: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}
