//
//  RootDomain.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 3/21/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct RootDomain {
    @Reducer(state: .equatable)
    enum Path {
        case popularMovieList(PopularMoviesDomain)
        case movieDetail(MovieDetailDomain)
    }
    
    @ObservableState
    struct State {
        var path = StackState<Path.State>()
    }
    
    enum Action {
        case goBackToScreen(id: StackElementID)
        case path(StackAction<Path.State, Path.Action>)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .goBackToScreen(id):
                state.path.pop(to: id)
                return .none
            case let .path(action):
                switch action {
                case .element(id: _, action: .popularMovieList(.movieDetailTapped(let id))):
                    state.path.append(.movieDetail(MovieDetailDomain.State(movieID: id)))
                    return .none
                case .element(id: _, action: .movieDetail(.navigateBack)):
                    state.path.popLast()
                    return .none
                    
                default:
                    return .none
                }
                
            default:
                return .none
//            case let .path(.element(id: id, action: .popularMovieList(.fetchMovieList(<#T##Int#>, <#T##String?#>))))
            }
        }.forEach(\.path, action: \.path)
    }
}
