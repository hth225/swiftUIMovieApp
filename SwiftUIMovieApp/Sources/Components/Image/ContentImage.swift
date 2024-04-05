//
//  ContentImage.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 4/4/24.
//

import SwiftUI

struct ContentImage: View {
    let posterPath: String
    let voteAverage: Double?
    
    init(posterPath: String, voteAverage: Double?) {
        self.posterPath = posterPath
        self.voteAverage = voteAverage
    }
    
    var body: some View {
        GeometryReader { proxy in
            AsyncImage(url: URL(string: posterPath)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(4)
                        .overlay {
                            if let average = voteAverage {
                                GeometryReader { imageProxy in
                                    ZStack(alignment: .center) {
                                        Circle()
                                            .fill(Color(red: 8/255, green: 28/255, blue: 34/255))
                                        HStack(alignment: .center, spacing: 0) {
                                            Text("\(Int(average * 10))")
                                                .font(.system(size: 24)).fontWeight(.medium)
                                                .foregroundColor(.white)
                                            Text("%")
                                                .font(.system(size: 8)).fontWeight(.medium)
                                                .foregroundColor(.white)
                                        }
                                    }
                                    .frame(width: 50, height: 50)
                                    .offset(x: 8, y: imageProxy.size.height - 30)
                                }
                            }
                        }
                } else if phase.error != nil {
                    // Display a placeholder when loading failed
                    Image(systemName: "questionmark.diamond")
                        .imageScale(.large)
                } else {
                    // Display a placeholder while loading
                    // size - padding
                    ProgressView()
                        .frame(width: proxy.size.width,
                               height: proxy.size.height)
                }
            }
        }
    }
}

#Preview {
    ContentImage(posterPath: ContentImageHelper.getURL(path: "/kCGlIMHnOm8JPXq3rXM6c5wMxcT.jpg"), voteAverage: 7.905)
}
