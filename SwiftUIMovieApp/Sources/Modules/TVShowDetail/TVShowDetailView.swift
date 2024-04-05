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
                            AsyncImage(url: URL(string: ContentImageHelper.getURL(path: info.posterPath))) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
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
                                        .frame(width: proxy.size.width,
                                               height: proxy.size.height)
                                }
                            }
                            
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
                            }.padding(.bottom, 4)
                            
                            // created by
                            if !info.createdBy.isEmpty {
                                Text("TVShowDetailTextCreatedBy")
                                    .title2()
                                    .padding(.bottom, 4)
                                ScrollView(.horizontal){
                                    HStack{
                                        ForEach(info.createdBy) { element in
                                            ShowDirectorCard(director: element)
                                        }
                                    }
                                }
                                .scrollIndicators(.hidden)
                                .padding(.bottom, 8)
                            }
                            
                            // seasons
                            if !info.seasons.isEmpty {
                                Text("TVShowDetailTextSeasons")
                                    .title2()
                                    .padding(.bottom, 4)
                                ScrollView(.horizontal){
                                    HStack{
                                        ForEach(info.seasons) { element in
                                            TVSeasonsCard(seasons: element)
                                        }
                                    }
                                }
                                .scrollIndicators(.hidden)
                                .padding(.bottom, 8)
                            }
                            
                            // production company
                            if !info.productionCompanies.isEmpty {
                                Text("TVShowDetailTextProductionCompany")
                                    .font(.title).fontWeight(.bold)
                                    .padding(.top, 16)
                                ScrollView(.horizontal){
                                    HStack{
                                        ForEach(info.productionCompanies) { element in
                                            VStack{
                                                if let posterPath = element.logoPath {
                                                    AsyncImage(url: URL(string: ContentImageHelper.getURL(path: posterPath))) { phase in
                                                        if let image = phase.image {
                                                            image
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 150,
                                                                       height: 200)
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
                                                } else {
                                                    Image(systemName: "play.tv")
                                                        .frame(width: 150,
                                                               height: 200)
                                                        .foregroundStyle(.white)
                                                        .background(.gray)
                                                        .cornerRadius(4)
                                                }
                                                
                                                Text(element.name)
                                                    .font(.title3).fontWeight(.bold)
                                                    .frame(width: 150)
                                                    .padding(.vertical, 4)
                                            }
                                            .padding(.horizontal, 2)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                                .scrollIndicators(.hidden)
                                .padding(.bottom, 8)
                                .padding(.horizontal, -16)
                            }
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
