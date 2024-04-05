//
//  TVShowDetailView.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 4/5/24.
//

import SwiftUI
import ComposableArchitecture

struct TVShowDetailView: View {
    @Bindable var store: StoreOf<TVShowDetailDomain>
    
    var body: some View {
        GeometryReader { proxy in
            if let info = store.info {
                BlurredImageBackground(imageURL: info.backdropPath) {
                    ScrollView {
                        VStack(alignment: .leading) {
                            // voteAverage nil 주어서 뱃지 비활성화
                            ContentImage(posterPath: info.posterPath, voteAverage: nil)
                            
                            HStack {
                                Text(info.name)
                                    .font(.largeTitle).fontWeight(.heavy)
                                Spacer()
                                ZStack(alignment: .center) {
                                    Circle()
                                        .fill(Color(red: 8/255, green: 28/255, blue: 34/255))
                                    HStack(alignment: .center, spacing: 0) {
                                        Text("\(Int(info.voteAverage * 10))")
                                            .font(.system(size: 24)).fontWeight(.medium)
                                            .foregroundColor(.white)
                                        Text("%")
                                            .font(.system(size: 8)).fontWeight(.medium)
                                            .foregroundColor(.white)
                                    }
                                }
                                .frame(width: 50, height: 50)
                                .padding(.trailing, 8)
                            }
                            
                            // genre
                            Text("\(info.genres.map({element in element.name}).joined(separator: ", "))")
                                .font(.subheadline).fontWeight(.bold)
                                .padding(.trailing, 4)
                            
                            // Release date, running time
                            Text("\(info.lastAirDate)")
                                .font(.subheadline).fontWeight(.bold)
                            // tagline
                            Text("\(info.tagline)")
                                .italic()
                                .font(.system(size: 24)).fontWeight(.light)
                                .padding(.top, 12)
                                .padding(.bottom, 8)
                            
                            Text("\(info.overview)")
                                .font(.system(size: 16)).fontWeight(.medium)
                                .padding(.bottom, 12)
                            
                            // created by
                            
                            Divider()
                            Text("TVShowDetailTextLearnMore")
                                .font(.title).fontWeight(.bold)
                                .padding(.bottom, 8)
                            
                            // original title
                            Text("TVShowDetailTextOriginalTitle")
                                .title2()
                            HStack{
                                Text(info.originalName)
                                    .font(.title3).fontWeight(.medium)
                                
                                Text("(\(info.productionCountries.map({element in element.iso3166_1}).joined(separator: ", ")))")
                                    .font(.title3)
                                    .fontWeight(.medium)
                            }
                            
                            // seasons
                            
                            // production company
                            Text("TVShowDetailTextProductionCompany")
                                .font(.title).fontWeight(.bold)
                                .padding(.top, 16)
                            
                        }
                        .padding(.horizontal)
                    }
                }
            } else {
                // Display a placeholder while loading
                // size - padding
                ProgressView()
                    .frame(width: proxy.size.width,
                           height: proxy.size.height)
                    .foregroundStyle(.black)
            }
        }
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .task {
            store.send(.fetchShowDetail(store.showID))
        }
    }
}

#Preview {
    TVShowDetailView(store: Store(initialState: TVShowDetailDomain.State(showID: 1433), reducer: {
        TVShowDetailDomain()
    }))
}
