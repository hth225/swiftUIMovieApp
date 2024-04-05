//
//  SmallPosterImage.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 4/5/24.
//

import SwiftUI

struct SmallPosterImage: View {
    var posterPath: String
    
    var body: some View {
        AsyncImage(url: URL(string: posterPath)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .frame(width: 150, height: 200)
                    .aspectRatio(contentMode: .fill)
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
