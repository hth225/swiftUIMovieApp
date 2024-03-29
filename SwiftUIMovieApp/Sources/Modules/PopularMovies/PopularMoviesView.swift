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
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                
                VisualEffectView(effect: UIBlurEffect(style: .dark))
                    .ignoresSafeArea()
                
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
                            .id(element.id)
                            .onTapGesture {
                                store.send(.movieDetailTapped(id: element.id))
                            }
                            .task {
                                // ResMovie의 첫번째 Element 가 보일때 다음 페이지 가져오기
                                if (element.id == store.checkPointID) {
                                    print("Requested: \(element.id), CheckPoint:\(String(describing: store.checkPointID))")
                                    store.send(.fetchMovieList(store.currentPage+1))
                                }
                            }
                        }.scrollTargetLayout()
                    }
                    .background(GeometryReader {proxy in
                        Color.clear
                            .preference(key: ScrollOffsetPreferenceKey.self, value: proxy.frame(in: .named("scroll")).origin)
                    })
                }
                .frame(width: geometryProxy.size.width, height: geometryProxy.size.height)
                .coordinateSpace(name:"scroll")
            }
        }
        .task {
            store.send(.fetchMovieList(store.currentPage+1))
        }
    }
    
    struct ScrollOffsetPreferenceKey: PreferenceKey {
        static var defaultValue: CGPoint = .zero

        static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
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
