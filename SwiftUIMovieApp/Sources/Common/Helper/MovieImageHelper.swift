//
//  MovieImageHelper.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 2024/03/13.
//

import Foundation

struct MovieImageHelper {
    static func getURL(_ imageWidth: Int? = nil, path: String) -> String {
        if let size = imageWidth {
            return "\(Constants.imageURL)/w\(String(size))\(path)"
        } else {
            return "\(Constants.imageURL)/original\(path)"
        }
    }
}
