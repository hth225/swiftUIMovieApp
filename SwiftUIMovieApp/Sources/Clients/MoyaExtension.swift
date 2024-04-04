//
//  MoyaExtension.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 4/4/24.
//

import Foundation
import Moya

extension MoyaProvider {
    func request<T: Decodable>(_ target: Target) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    do {
                        let res = try JSONDecoder().decode(T.self, from: response.data)
                        continuation.resume(returning: res)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
