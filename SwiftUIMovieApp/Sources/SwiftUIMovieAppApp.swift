import SwiftUI
import ComposableArchitecture

@main
struct SwiftUIMovieAppApp: App {
    var body: some Scene {
        WindowGroup {
//            PopularMoviesView(store: Store(initialState: PopularMoviesDomain.State()){
//                PopularMoviesDomain()
//            })
//            .foregroundStyle(.white)
            RootView(store: Store(initialState: RootDomain.State()){
                RootDomain()
            })
            .foregroundStyle(.white)
        }
    }
}
