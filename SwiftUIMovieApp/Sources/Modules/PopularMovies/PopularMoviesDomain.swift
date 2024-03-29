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
    @Dependency(\.movieClient) var movieClient
    
    @ObservableState
    struct State: Equatable {
        var currentPage: Int = 0
        var movieList: [ResMovie] = []
        // API Response 리스트의 첫번째 Element id.
        var checkPointID: Int?
        // 중복 호출 방지 리스트
        var requestedIDList: [Int] = []
    }
    
    enum Action {
        case fetchMovieList(Int)
        case movieListResponse(Result<ResMovieList, Error>)
        case movieDetailTapped(id: Int)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .fetchMovieList(page):
                return .run { send in
                    await send(.movieListResponse(Result {
                        try await movieClient.getPopularMovies(reqMovieList: ReqMovieList(page: page, language: Locale.current.language.languageCode?.identifier))
                    }))
                }
            case let .movieListResponse(.success(movieList)):
                state.currentPage = movieList.page
                state.movieList.append(contentsOf: movieList.results)
                
                // 다음 페이지를 불러올 기준으로 쓰일 ID
                state.checkPointID = movieList.results.first!.id
                print("Appended ID : \(movieList.results.first!.id)")
                return .none
            case let .movieListResponse(.failure(error)):
                print("API Error:\(error)")
                return .none
            case let .movieDetailTapped(id):
                return .none
            }
        }
    }
}
