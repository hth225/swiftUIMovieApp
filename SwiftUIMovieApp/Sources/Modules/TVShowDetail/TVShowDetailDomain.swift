//
//  TVShowDetail.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 4/4/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct TVShowDetailDomain {
    @Dependency(\.tvClient) var tvClient
    
    @ObservableState
    struct State: Equatable {
        var showID: Int
        var info: ResTVShowDetail?
        
        init(showID: Int, _ info: ResTVShowDetail? = nil) {
            self.showID = showID
            self.info = info
        }
    }
    
    enum Action {
        case fetchShowDetail(Int)
        case fetchResponse(Result<ResTVShowDetail, Error>)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case.fetchShowDetail(let id):
                return .run { send in
                    await send(.fetchResponse(Result{
                        try await tvClient.getTVShowDetail(reqTVShowDetail: ReqTVShowDetail(showID: id, language: Locale.current.language.languageCode?.identifier))
                    }))
                }
            case let .fetchResponse(.success(result)):
                state.info = result
                return .none
            case let .fetchResponse(.failure(error)):
                print("API ERROR : \(error)")
                return .none
            }
            
        }
    }
}
