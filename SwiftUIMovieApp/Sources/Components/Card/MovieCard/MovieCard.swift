//
//  MovieCard.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 2024/03/13.
//

import SwiftUI

// A Simple movie card for movie list
struct MovieCard: View {
    let movie: SimplifiedMovie
    
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading) {
                AsyncImage(url:URL(string:  MovieImageHelper.getURL(path: self.movie.posterPath))) { phase in
                    if let image = phase.image {
                        // Display the loaded image
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(4)
                            .overlay {
                                GeometryReader { imageProxy in
                                    ZStack(alignment: .center) {
                                        Circle()
                                            .fill(Color(red: 8/255, green: 28/255, blue: 34/255))
                                        HStack(alignment: .center, spacing: 0) {
                                            Text("\(Int(self.movie.voteAverage * 10))")
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
                        
                    } else if phase.error != nil {
                        // Display a placeholder when loading failed
                        Image(systemName: "questionmark.diamond")
                            .imageScale(.large)
                    } else {
                        // Display a placeholder while loading
                        // size - padding
                        ProgressView()
                            .frame(width: proxy.size.width - 40,
                                   height: (proxy.size.width - 40) * 1.5)
                    }
                }
                .padding(.bottom, 12)
                
                Text(self.movie.title)
                    .font(.system(.title2)).fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 2)
                    .padding(.leading, 8)
                Text(dateConverter(self.movie.releaseDate))
                    .font(.system(size: 16))
                    .padding(.leading, 8)
            }
            .padding(20)
            .background(.clear)
        }
    }
    
    func dateConverter(_ dateString: String) -> String {
        let originFormatter = DateFormatter()
        let destFormatter = DateFormatter()
        
        originFormatter.dateFormat = "yyyy-MM-dd"
        destFormatter.dateFormat = "MMM d yyyy"
        
        if let converted = originFormatter.date(from: dateString) {
            return destFormatter.string(from: converted)
        } else {
            return " - "
        }
    }
}

struct MovieCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieCard(movie: SimplifiedMovie(id: 792307, posterPath:"/kCGlIMHnOm8JPXq3rXM6c5wMxcT.jpg", releaseDate:"2023-12-07" , title: "Poor Things", voteAverage: 7.905))
    }
}
