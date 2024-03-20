//
//  MovieCardDomain.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 3/20/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MovieCardDomain {
    @ObservableState
    struct State: Equatable {
        var movieInfo: ResMovie
    }
    
    enum Action {
        
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            }
        }
    }
}
