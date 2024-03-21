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
            Text("Hello World")
        }
        destination: { store in
            switch store.state {
            case .popularMovieList:
                if let store = store.scope(state: \.popularMovieList, action: \.popularMovieList) {
                    PopularMoviesView(store: store)
                }
            }
        }
    }
}

#Preview {
    RootView(store: Store(initialState: RootDomain.State()){
        RootDomain()
    })
}
