//
//  MovieDetailDomain.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 3/27/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MovieDetailDomain {
    @Dependency(\.movieClient) var movieClient
    
    @ObservableState
    struct State: Equatable {
        var movieID: Int
        var movieInfo: ResMovieDetail?
        
        init(movieID: Int, _ movieInfo: ResMovieDetail? = nil) {
            self.movieID = movieID
            self.movieInfo = movieInfo
        }
    }
    
    enum Action {
        case navigateBack
        case fetchMovieDetail(Int)
        case movieDetailResponse(Result<ResMovieDetail, Error>)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .navigateBack:
                return .none
            case .fetchMovieDetail(let id):
                return .run { send in
                    await send(.movieDetailResponse(Result {
                        try await movieClient.getMovieDetail(reqMovieDetail: ReqMovieDetail(movieID: id, language: Locale.current.language.languageCode?.identifier))
                    }))
                }
            case let .movieDetailResponse(.success(result)):
                state.movieInfo = result
                
                return .none
            case let .movieDetailResponse(.failure(error)):
                print("API ERROR : \(error)")
                return .none
            }
        }
    }
}
