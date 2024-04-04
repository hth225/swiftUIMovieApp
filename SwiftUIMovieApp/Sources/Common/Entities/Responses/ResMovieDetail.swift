//
//  ResMovieDetail.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 3/28/24.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let resMovieDetail = try? JSONDecoder().decode(ResMovieDetail.self, from: jsonData)

import Foundation

// MARK: - ResMovieDetail
struct ResMovieDetail: Codable, Identifiable, Equatable, Sendable {
    let adult: Bool
    let backdropPath: String?
    let belongsToCollection: MovieCollection?
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdbID, originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let revenue, runtime: Int
    let spokenLanguages: [SpokenLanguage]
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    static func == (lhs: ResMovieDetail, rhs: ResMovieDetail) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - BelongsToCollection
struct MovieCollection: Codable {
    let id: Int
    let name, posterPath: String
    let backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
