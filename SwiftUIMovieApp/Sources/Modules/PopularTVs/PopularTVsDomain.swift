//
//  PopularTVsDomain.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 4/3/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct PopularTVsDomain {
    @Dependency(\.tvClient) var tvClient
    
    @Reducer(state: .equatable)
    enum Path {
//        case navigateToTVDetail(TVDetailDomain)
    }
    
    @ObservableState
    struct State: Equatable {
        var currentPage: Int = 0
        var tvList : [ResTV] = []
        // page 별 API 리스트의 첫 번째 항목 ID 값.
        var checkPointID: Int?
        // 중복 호출 방지. checkPointID 와 이 리스트로 교차검증해서 api call 함
        var requestedIDList: [Int] = []
//                var path = StackState<Path.State>()
    }
    
    enum Action {
        case fetchTVList(Int)
        case tvListResponse(Result<ResTVList, Error>)
        case tvDetailTapped(Int)
//                case path(StackAction<Path.State, Path.Action>)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .fetchTVList(page):
                return .run { send in
                    await send(.tvListResponse(Result {
                        try await tvClient.getPopularTVs(reqTVList: ReqTVList(page: page, language: Locale.current.language.languageCode?.identifier))
                    }))
                }
            case let .tvListResponse(.success(result)):
                state.currentPage = result.page
                state.tvList.append(contentsOf: result.results)
                
                state.checkPointID = result.results.first!.id
                return .none
                
            case let .tvListResponse(.failure(error)):
                print("API Error:\(error)")
                return .none
            case let .tvDetailTapped(id):
//                state.path.append(.navigateToTVDetail(TVDetailDomain.State(id: id)))
                return .none
            }
            
        }
//        .forEach(\.path, action: \.path)
    }
}
