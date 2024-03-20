import SwiftUI
import ComposableArchitecture

@main
struct SwiftUIMovieAppApp: App {
    var body: some Scene {
        WindowGroup {
            PopularMoviesView(store: Store(initialState: PopularMoviesDomain.State()){
                PopularMoviesDomain()
            })
        }
    }
}
