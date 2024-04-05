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
        var id: Int
        var info: ResTVShowDetail?
        
        init(id: Int, info: ResTVShowDetail? = nil) {
            self.id = id
            self.info = info
        }
    }
}
