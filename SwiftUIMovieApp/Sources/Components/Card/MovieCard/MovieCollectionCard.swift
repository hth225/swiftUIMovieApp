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
            AsyncImage(url: URL(string: ContentImageHelper.getURL(path: collection.posterPath))) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .frame(width: 150, height: 200)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(4)
                } else if phase.error != nil {
                    // Display a placeholder when loading failed
                    Image(systemName: "questionmark.diamond")
                        .imageScale(.large)
                } else {
                    // Display a placeholder while loading
                    // size - padding
                    ProgressView()
                        .frame(width: 150,
                               height: 200)
                }
            }
        }
    }
}

#Preview {
    MovieCollectionCard(collection: MovieCollection(id: 726871, name: "Dune Collection", posterPath: "/wcVafar6Efk3YgFvh8oZQ4yHL6H.jpg", backdropPath: "/ygVSGv86R0BTOKJIb8RQ1sFxs4q.jpg"))
}
