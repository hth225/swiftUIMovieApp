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
        
        //            NavigationLink("Popular movies", state: RootDomain.Path.State.popularMovieList(PopularMoviesDomain.State())).foregroundStyle(.black)
        TabView {
            Group {
                PopularMoviesView(store: Store(initialState: PopularMoviesDomain.State()){
                    PopularMoviesDomain()
                })
                .tabItem {
                    Image(systemName: "movieclapper")
                    Text("Movies")
                }
                
                PopularTVsView(store: Store(initialState: PopularTVsDomain.State()){
                    PopularTVsDomain()
                })
                .tabItem {
                    Image(systemName: "play.tv.fill")
                    Text("TV")
                }
            }
            .toolbarBackground(Color("TabbarBackground"), for: .tabBar)
        }
        
    }
}

#Preview {
    RootView(store: Store(initialState: RootDomain.State()){
        RootDomain()
    })
}
