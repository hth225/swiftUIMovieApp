//
//  MovieClient.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 2024/03/14.
//

import Foundation
import ComposableArchitecture
import Moya
import CombineMoya
import Combine

@DependencyClient
struct MovieClient {
//    static func getPopularMovies(page: Int, language: String?) -> Effect<[ResMovie], Error> {
//        let provider = MoyaProvider<TmdbAPI>()
//        return provider.requestPublisher(.getPopularMovies(page: page, language: language))
//            .map([page].self)
//            .mapError { $0 as Error }
//            .eraseToAnyPublisher()
//    }
    
//    var getPopularMovies: @Sendable (_ page: Int, _ language: String?) async throws -> AnyPublisher<ResMovieList, Error>
    var getPopularMovies: @Sendable (_ reqMovieList: ReqMovieList, _ complietion: @escaping (Result<ResMovieList, Error>) -> Void) -> Void
}

extension MovieClient: DependencyKey {
    static let liveValue = MovieClient(getPopularMovies: { (reqMovieList, completion)  in
//        Future<[ResMovie], Error> { promise in
//            let provider = MoyaProvider<TmdbAPI>()
//            
//            provider.requestPublisher(.getPopularMovies(page: page, language: language))
//                .sink(receiveCompletion: {completion in
//                    switch completion {
//                    case .finished:
//                        print("Completed")
//                    case .failure(let error):
//                        print("Failed")
//                        promise(.failure(error))
//                    }
//                }, receiveValue: {response in
//                    let result = try? JSONDecoder().decode([ResMovie].self, from: response.data)
//                    promise(.success(result!))
//                })
//        }
//        .eraseToAnyPublisher()
        
//        let provider = MoyaProvider<TmdbAPI>()
//        return provider.requestPublisher(.getPopularMovies(page: page, language: language)).tryMap { response in
//            return try JSONDecoder().decode(ResMovieList.self, from: response.data)
//        }.eraseToAnyPublisher()
        
        let provider = MoyaProvider<TmdbAPI>()
        
        provider.request(.getPopularMovies(page: reqMovieList.page, language: reqMovieList.language)) { result in
            switch result {
            case .success(let response):
                do {
                    completion(.success(try JSONDecoder().decode(ResMovieList.self, from: response.data)))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
//
//        provider.request(.getPopularMovies(page: page, language: language)) {response in
//            switch response {
//            case .success(let result):
//                print(result)
//            case .failure(let error):
//                print(error)
//            }
//        }
    })
}

extension DependencyValues {
  var movieClient: MovieClient {
    get { self[MovieClient.self] }
    set { self[MovieClient.self] = newValue }
  }
}
