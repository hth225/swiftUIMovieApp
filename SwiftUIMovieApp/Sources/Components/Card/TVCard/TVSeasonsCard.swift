//
//  TVSeasonsCard.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 4/5/24.
//

import SwiftUI

struct TVSeasonsCard: View {
    var seasons: Season
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(seasons.airDate ?? " - ")
                .font(.subheadline).fontWeight(.bold)
                .foregroundStyle(seasons.airDate != nil ? .white : .clear)
            
            if let posterPath = seasons.posterPath {
                SmallPosterImage(posterPath: ContentImageHelper.getURL(path: posterPath))
            } else {
                Image(systemName: "play.tv")
                    .frame(width: 150,
                           height: 200)
                    .foregroundStyle(.white)
                    .background(.gray)
                    .cornerRadius(4)
            }
            
            Text(seasons.name)
                .font(.title3).fontWeight(.bold)
                .padding(.vertical, 4)
            
        }
    }
}

#Preview {
    TVSeasonsCard(seasons: Season(airDate: "2005-02-06",episodeCount: 7, id: 3811, name: "Season 1", overview: "From the delightfully twisted creative minds behind 'Family Guy' comes 'American Dad', the animated tour de force featuring CIA operative Stan Smith, his outrageous family and Roger, the alcoholic extraterrestrial who lives with them! Follow the adventures of the Smiths from the California desert, where Stan's wife, Francine, relives her teenage years at the Burning Man festival, to Saudi Arabia, where the entire family is sentenced to death by the Vice and Virtue Police! Whether it's rigging elections, erasing memories, casing sleazy strip clubs, or staging \"bum fights\", it's all in a day's work for Stan, and it's all here in the side-splittingly hilarious first season of 'American Dad'!",posterPath: "/pZpq1Szw4ArTapXLCtxLEDtsiYn.jpg", seasonNumber: 1, voteAverage: 2.5))
}
