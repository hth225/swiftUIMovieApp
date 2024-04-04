//
//  MovieClient.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 2024/03/14.
//

import Foundation
import ComposableArchitecture
import Moya

@DependencyClient
struct MovieClient {
    var getPopularMovies: @Sendable (_ reqMovieList: ReqMovieList) async throws -> ResMovieList
    var getMovieDetail: @Sendable (_ reqMovieDetail: ReqMovieDetail) async throws -> ResMovieDetail
}

extension MovieClient: DependencyKey {
    static let liveValue = MovieClient(getPopularMovies: { (reqMovieList)  in
        let provider = MoyaProvider<TmdbAPI>()
        
        return try await provider.request<ResMovieList>(.getPopularMovies(page: reqMovieList.page, language: reqMovieList.language))
    }, getMovieDetail: {(reqMovieDetail) in
        let provider = MoyaProvider<TmdbAPI>()
        
        return try await provider.request(.getMovieDetail(id: reqMovieDetail.movieID, reqMovieDetail.language))
    } )
}

extension DependencyValues {
  var movieClient: MovieClient {
    get { self[MovieClient.self] }
    set { self[MovieClient.self] = newValue }
  }
}
