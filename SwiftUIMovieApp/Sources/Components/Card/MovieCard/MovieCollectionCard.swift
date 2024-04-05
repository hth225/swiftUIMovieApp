//
//  MovieCollectionCard.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 3/28/24.
//

import SwiftUI

struct MovieCollectionCard: View {
    let collection: MovieCollection
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(collection.name)
                .font(.title2).fontWeight(.medium)
            SmallPosterImage(posterPath: ContentImageHelper.getURL(path: collection.posterPath))
        }
    }
}

#Preview {
    MovieCollectionCard(collection: MovieCollection(id: 726871, name: "Dune Collection", posterPath: "/wcVafar6Efk3YgFvh8oZQ4yHL6H.jpg", backdropPath: "/ygVSGv86R0BTOKJIb8RQ1sFxs4q.jpg"))
}
