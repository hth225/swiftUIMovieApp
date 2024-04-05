//
//  EpisodeInfo.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 4/5/24.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let episodeInfo = try? JSONDecoder().decode(EpisodeInfo.self, from: jsonData)

import Foundation

// MARK: - EpisodeInfo
struct EpisodeInfo: Codable {
    let id: Int
    let name, overview: String
    let voteAverage: Double
    let voteCount: Int
    let airDate: String
    let episodeNumber: Int
    let episodeType, productionCode: String
    let runtime: Int?
    let seasonNumber, showID: Int
    let stillPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name, overview
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case episodeType = "episode_type"
        case productionCode = "production_code"
        case runtime
        case seasonNumber = "season_number"
        case showID = "show_id"
        case stillPath = "still_path"
    }
}
