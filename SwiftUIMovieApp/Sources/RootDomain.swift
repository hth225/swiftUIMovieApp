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
        
    }
    
    @ObservableState
    struct State {
        
    }
    
    enum Action {
        
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            
            default:
                return .none
            }
        }
//        .forEach(\.path, action: \.path)
    }
}
