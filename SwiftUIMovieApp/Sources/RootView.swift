//
//  RootView.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 3/21/24.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    @Bindable var store: StoreOf<RootDomain>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            NavigationLink("Popular movies", state: RootDomain.Path.State.popularMovieList(PopularMoviesDomain.State())).foregroundStyle(.black)
        }
        destination: { store in
            switch store.case {
            case let .popularMovieList(store):
                PopularMoviesView(store: store)
            case let .movieDetail(store):
                MovieDetailView(store: store)
            }
        }
    }
}

#Preview {
    RootView(store: Store(initialState: RootDomain.State()){
        RootDomain()
    })
}
