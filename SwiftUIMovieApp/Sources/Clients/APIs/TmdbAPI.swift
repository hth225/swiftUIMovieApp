//
//  TmdbAPI.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 2024/03/14.
//

import Foundation
import Moya


enum TmdbAPI {
    case getPopularMovies(page: Int, language: String?)
    case getMovieDetail(id: Int, _ language: String?)
    case getPopularTV(page: Int, language: String?)
    case getTVShowDetail(id: Int, _ language: String?)
}

extension TmdbAPI: TargetType {
    var baseURL: URL {
        URL(string: Constants.baseAPIURL)!
    }
    
    var path: String {
        switch self {
        case .getPopularMovies(page: _, language: _) : return Constants.popluarMovieURL
        case .getMovieDetail(id: let movieID, _): return Constants.movieDetailURL(movieID: movieID)
        case .getPopularTV(page: _, language: _): return Constants.popluarTVURL
        case .getTVShowDetail(id: let showID, _): return Constants.tvShowDetailURL(showID: showID)
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPopularMovies(page: _), .getMovieDetail(id: _, _), .getPopularTV(page: _, language: _), .getTVShowDetail(id: _, _) : return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getPopularMovies(page: let page, language: let language) :
            let params : [String: String] = [ "page" : String(page), "language" : language ?? "en-US" ]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .getMovieDetail(id: _, let language), .getTVShowDetail(id: _, let language):
            let params : [String: String] = ["language" : language ?? "en-US"]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .getPopularTV(page: let id, language: let language):
            let params : [String: String] = ["page" : String(id), "language" : language ?? "en-US" ]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getPopularMovies(page: _), .getMovieDetail(id: _, _), .getPopularTV(page: _, language: _), .getTVShowDetail(id: _, _):
            return [ "Authorization" : Constants.apiKey, "accept" : "application/json" ]
        }
    }
    
    var validationType: ValidationType { .successCodes }
}
