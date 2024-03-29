//
//  MovieDetailView.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 3/27/24.
//

import SwiftUI
import ComposableArchitecture

struct MovieDetailView: View {
    @Bindable var store: StoreOf<MovieDetailDomain>
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                if let backdrop = store.movieInfo.backdropPath {
                    AsyncImage(url: URL(string: MovieImageHelper.getURL(path: backdrop))) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .ignoresSafeArea()
                                .frame(width: proxy.size.width, height: proxy.size.height)
                                .blur(radius: 8)
                        }
                    }.padding(.all, 0)
                }
                
                VisualEffectView(effect: UIBlurEffect(style: .dark))
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading){
                        AsyncImage(url: URL(string: MovieImageHelper.getURL(path: store.movieInfo.posterPath))) { phase in
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
                                    .frame(width: proxy.size.width - 40,
                                           height: (proxy.size.width - 40) * 1.5)
                            }
                        }
                        
                        
                        // title, average rate
                        HStack{
                            VStack(alignment: .leading) {
                                // title
                                Text("\(store.movieInfo.title) ")
                                    .font(.largeTitle).fontWeight(.heavy)
                                
                            }
                            Spacer()
                            ZStack(alignment: .center) {
                                Circle()
                                    .fill(Color(red: 8/255, green: 28/255, blue: 34/255))
                                HStack(alignment: .center, spacing: 0) {
                                    Text("\(Int(store.movieInfo.voteAverage * 10))")
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
                        Text("\(store.movieInfo.genres.map({element in element.name}).joined(separator: ", "))")
                            .font(.subheadline).fontWeight(.bold)
                            .padding(.trailing, 4)
                        
                        // Release date, running time
                        Text("\(store.movieInfo.releaseDate), \(Int(store.movieInfo.runtime/60))h \(store.movieInfo.runtime.remainderReportingOverflow(dividingBy: 60).partialValue)m")
                            .font(.subheadline).fontWeight(.bold)
                        
                        Text("\(store.movieInfo.tagline)")
                            .italic()
                            .font(.system(size: 24)).fontWeight(.light)
                            .padding(.top, 12)
                            .padding(.bottom, 8)
                        
                        Text("\(store.movieInfo.overview)")
                            .font(.system(size: 16)).fontWeight(.medium)
                            .padding(.bottom, 12)
                        
                        if let movieCollection = store.movieInfo.belongsToCollection {
                            Text("Collections")
                                .font(.title).fontWeight(.bold)
                                .padding(.bottom, 8)
                            MovieCollectionCard(collection: movieCollection)
                                .padding(.bottom, 8)
                        }
                        
                        Divider()
                        Text("Learn more")
                            .font(.title).fontWeight(.bold)
                            .padding(.bottom, 8)
                        Text("Original title")
                            .font(.title2).fontWeight(.bold)
                        HStack{
                            Text(store.movieInfo.originalTitle)
                                .font(.title3).fontWeight(.medium)
                            
                            Text("(\(store.movieInfo.productionCountries.map({element in element.iso3166_1}).joined(separator: ", ")))")
                                .font(.title3)
                                .fontWeight(.medium)
                        }
                        
                        Text("Budget")
                            .font(.title2).fontWeight(.bold)
                        Text("\(store.movieInfo.budget.formatted(.currency(code: "USD")))")
                            .font(.body).fontWeight(.bold)
                        
                        Text("Revenue")
                            .font(.title2).fontWeight(.bold)
                        Text("\(store.movieInfo.revenue.formatted(.currency(code: "USD")))")
                            .font(.body).fontWeight(.bold)
                        
                        Text("Production company")
                            .font(.title).fontWeight(.bold)
                            .padding(.top, 16)
                        HStack {
                            ForEach(store.movieInfo.productionCompanies) { element in
                                AsyncImage(url: URL(string: MovieImageHelper.getURL(path: element.logoPath))) { phase in
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
                                            .frame(width: 36,
                                                   height: 36)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
}

#Preview {
    MovieDetailView(store: Store(initialState: MovieDetailDomain.State(movieInfo: ResMovieDetail(adult: false, backdropPath: "/87IVlclAfWL6mdicU1DDuxdwXwe.jpg", belongsToCollection: MovieCollection(id: 726871, name: "Dune Collection", posterPath: "/wcVafar6Efk3YgFvh8oZQ4yHL6H.jpg", backdropPath: "/ygVSGv86R0BTOKJIb8RQ1sFxs4q.jpg"), budget: 190000000, genres: [Genre(id: 878, name: "Science Fiction"), Genre(id: 12, name: "Adventure")], homepage: "https://www.dunemovie.com", id: 693134, imdbID: "", originalLanguage: "en", originalTitle: "Dune: Part Two", overview: "Follow the mythic journey of Paul Atreides as he unites with Chani and the Fremen while on a path of revenge against the conspirators who destroyed his family. Facing a choice between the love of his life and the fate of the known universe, Paul endeavors to prevent a terrible future only he can foresee.", popularity: 739.18, posterPath: "/czembW0Rk1Ke7lCJGahbOhdCuhV.jpg", productionCompanies: [ProductionCompany(id: 923, logoPath: "/8M99Dkt23MjQMTTWukq4m5XsEuo.png", name: "Legendary Pictures", originCountry: "US")], productionCountries: [ProductionCountry(iso3166_1: "US", name: "United States of America")], releaseDate: "2024-02-27", revenue: 574672149, runtime: 167, spokenLanguages: [SpokenLanguage(englishName: "English", iso639_1: "en", name: "English")], status: "Released", tagline: "Long live the fighters.", title: "Dune: Part Two", video: false, voteAverage: 8.393, voteCount: 2711))){
        MovieDetailDomain()
    })
}
