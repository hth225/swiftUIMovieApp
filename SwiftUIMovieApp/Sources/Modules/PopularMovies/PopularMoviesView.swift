//
//  PopularMoviesView.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 2024/03/13.
//

import SwiftUI
import ComposableArchitecture

struct PopularMoviesView: View {
    @Bindable var store: StoreOf<PopularMoviesDomain>
    
    var body: some View {
        GeometryReader { geometryProxy in
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())], alignment: .center, spacing: 4) {
                    ForEach(store.movieList) { element in
                        MovieCard(movie: SimplifiedMovie(id: element.id,
                                                         posterPath: element.posterPath,
                                                         releaseDate: element.releaseDate,
                                                         title: element.title,
                                                         voteAverage: element.voteAverage))
                        .frame(width: geometryProxy.size.width / 2,
                               height: geometryProxy.size.height / 2)
                    }
                }
            }
            .frame(width: geometryProxy.size.width, height: geometryProxy.size.height)
        }
        .background(Color("Background"))
        .task {
            store.send(.fetchMovieList(store.currentPage+1, nil))
        }
    }
}

struct PopularMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        PopularMoviesView(store: Store(initialState: PopularMoviesDomain.State()){
            PopularMoviesDomain()
        })
    }
}
