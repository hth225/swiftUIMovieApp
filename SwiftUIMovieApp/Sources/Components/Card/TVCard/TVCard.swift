//
//  TVCard.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 4/4/24.
//

import SwiftUI

struct TVCard: View {
    let info: ResTV
    
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading) {
                ContentImage(posterPath: ContentImageHelper.getURL(path: info.posterPath), voteAverage: info.voteAverage)
                    .padding(.bottom, 12)
//                    .frame(width: proxy.size.width, height: proxy.size.height)
                
                Text(info.name)
                    .font(.system(.title2)).fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 2)
                    .padding(.leading, 8)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .truncationMode(.tail)
                Text(dateConverter(info.firstAirDate))
                    .font(.system(size: 16))
                    .padding(.leading, 8)
            }
            .padding(20)
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

#Preview {
    TVCard(info: ResTV(adult: false, backdropPath: "/gMMnf8VRg3Z98WaFmOLr9Jk8pIs.jpg", genreIDS: [
        35,
        10767
      ], id: 63770, originCountry: [
        "US"
      ], originalLanguage: "en", originalName: "The Late Show with Stephen Colbert", overview: "Stephen Colbert brings his signature satire and comedy to The Late Show with Stephen Colbert, the #1 show in late night, where he talks with an eclectic mix of guests about what is new and relevant in the worlds of politics, entertainment, business, music, technology, and more. Featuring bandleader Jon Batiste with his band Stay Human, the Emmy Award-nominated show is broadcast from the historic Ed Sullivan Theater. Stephen Colbert, Chris Licht, Tom Purcell, and Jon Stewart are executive producers. Barry Julien and Denise Rehrig serve as co-executive producers.must watch", popularity: 6091.068, posterPath: "/9jkThAGYj2yp8jsS6Nriy5mzKFT.jpg", firstAirDate: "2015-09-08", name: "The Late Show with Stephen Colbert", voteAverage:  6.512, voteCount: 252))
}
