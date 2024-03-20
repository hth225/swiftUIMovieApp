//
//  PopularMoviesDomain.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 3/20/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct PopularMoviesDomain {
    @ObservableState
    struct State: Equatable {
        var currentPage: Int = 0
        var movieList: [ResMovie] = []
    }
    
    enum Action {
        case fetchMovieList(Int, String?)
        case movieListResponse(Result<ResMovieList, Error>)
    }
    
    @Dependency(\.movieClient) var movieClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .fetchMovieList(page, language):
                return .run { send in
                    movieClient.getPopularMovies(reqMovieList: ReqMovieList(page: page, language: language)) { result in
                        Task {
                            switch result {
                            case .success(let movieList):
                                print("")
                                await send(.movieListResponse(.success(movieList)))
                                
                            case .failure(let error):
                                print("")
                                await send(.movieListResponse(.failure(error)))
                            }
                        }
                    }
                }
            case let .movieListResponse(.success(movieList)):
                state.currentPage = movieList.page
                state.movieList.append(contentsOf: movieList.results)
                return .none
            case let .movieListResponse(.failure(error)):
                return .none
            }
        }
    }
}
