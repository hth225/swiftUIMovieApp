//
//  SpokenLanguage.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 4/4/24.
//

import Foundation

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}
