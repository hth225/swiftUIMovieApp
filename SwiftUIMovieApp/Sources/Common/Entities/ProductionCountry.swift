//
//  ProductionCountry.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 4/4/24.
//

import Foundation

// MARK: - ProductionCountry
struct ProductionCountry: Codable, Hashable {
    let iso3166_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}
