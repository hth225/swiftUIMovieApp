//
//  TVClient.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 4/4/24.
//

import Foundation
import ComposableArchitecture
import Moya

@DependencyClient
struct TVClient {
    var getPopularTVs: @Sendable (_ reqTVList: ReqTVList) async throws -> ResTVList
}

extension TVClient: DependencyKey {
    static var liveValue = TVClient(
        getPopularTVs: { (reqTVList) in
            let provider = MoyaProvider<TmdbAPI>()
            
            return try await provider.request(.getPopularTV(page: reqTVList.page, language: reqTVList.language))
        })
}

extension DependencyValues {
  var tvClient: TVClient {
    get { self[TVClient.self] }
    set { self[TVClient.self] = newValue }
  }
}


