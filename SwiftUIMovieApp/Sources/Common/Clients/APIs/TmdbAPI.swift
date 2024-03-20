//
//  TmdbAPI.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 2024/03/14.
//

import Foundation
import Moya


enum TmdbAPI {
    case getPopularMovies(page: Int, language: String? = "en-US")
}

extension TmdbAPI: TargetType {
    var baseURL: URL {
        URL(string: Constants.baseAPIURL)!
    }
    
    var path: String {
        switch self {
            case .getPopularMovies(page: _, language: _) : return Constants.popluarMovieURL
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPopularMovies(page: _) : return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getPopularMovies(page: let page, language: let language) :
            let params : [String: String] = [ "page" : String(page), "language" : language ?? "en-US" ]
            return .requestParameters(parameters: params, encoding: URLEncoding.default )
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getPopularMovies(page: _) :
            return [ "Authorization" : Constants.apiKey, "accept" : "application/json" ]
        }
    }
    
    var validationType: ValidationType { .successCodes }
}
