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
    @ObservableState
    struct State: Equatable {
        var movieInfo: ResMovieDetail
    }
    
    enum Action {
        case navigateBack
        case fetchMovieDetail
        case movieDetailResponse(Result<ResMovieDetail, Error>)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .navigateBack:
                // navigate pop action
                return .none
            case .fetchMovieDetail:
//                return .run {
//                    
//                }
                return .none
            case .movieDetailResponse:
                return .none
            }
        }
    }
}
