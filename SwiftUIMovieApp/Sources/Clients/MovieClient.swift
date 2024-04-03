//
//  MovieClient.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 2024/03/14.
//

import Foundation
import ComposableArchitecture
import Moya
import CombineMoya
import Combine

@DependencyClient
struct MovieClient {
    var getPopularMovies: @Sendable (_ reqMovieList: ReqMovieList) async throws -> ResMovieList
    var getMovieDetail: @Sendable (_ reqMovieDetail: ReqMovieDetail) async throws -> ResMovieDetail
    var getPopularTVs: @Sendable (_ reqTVList: ReqTVList) async throws -> ResTVList
}

extension MovieClient: DependencyKey {
    static let liveValue = MovieClient(getPopularMovies: { (reqMovieList)  in
        let provider = MoyaProvider<TmdbAPI>()
        
        return try await provider.request<ResMovieList>(.getPopularMovies(page: reqMovieList.page, language: reqMovieList.language))
    }, getMovieDetail: {(reqMovieDetail) in
        let provider = MoyaProvider<TmdbAPI>()
        
        return try await provider.request(.getMovieDetail(id: reqMovieDetail.movieID, reqMovieDetail.language))
    }, getPopularTVs: { (reqTVList) in
        let provider = MoyaProvider<TmdbAPI>()
        
        return try await provider.request(.getPopularTV(page: reqTVList.page, language: reqTVList.language))
    } )
}

extension DependencyValues {
  var movieClient: MovieClient {
    get { self[MovieClient.self] }
    set { self[MovieClient.self] = newValue }
  }
}

extension MoyaProvider {
    func request<T: Decodable>(_ target: Target) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    do {
                        let res = try JSONDecoder().decode(T.self, from: response.data)
                        continuation.resume(returning: res)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
