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
    @ObservableState
    struct State {
        var path = StackState<Path.State>()
    }
    
    enum Action {
        case path(StackAction<Path.State, Path.Action>)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            default:
                return .none
//            case let .path(.element(id: id, action: .popularMovieList(.fetchMovieList(<#T##Int#>, <#T##String?#>))))
            }
        }.forEach(\.path, action: \.path) {
            Path()
        }
    }
}

extension RootDomain {
    @Reducer
    struct Path {
        @ObservableState
        enum State {
            case popularMovieList(PopularMoviesDomain.State)
        }
        
        enum Action {
            case popularMovieList(PopularMoviesDomain.Action)
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: \.popularMovieList, action: \.popularMovieList) {
                PopularMoviesDomain()
            }
        }
    }
}
