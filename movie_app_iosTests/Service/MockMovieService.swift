//
//  MockMovieService.swift
//  movie_app_iosTests
//
//  Created by Reynaldi Pamungkas on 22/12/22.
//

import Foundation
@testable import movie_app_ios

class MockMovieService: MovieServiceProtocol {
    var response: String?
    
    func getNowPlaying(parameters: [String : Any], completion: @escaping (Result<Movies, Error>) -> Void) {
        if let response = response {
            let jsonData = response.data(using: .utf8)!
            let result = try! JSONDecoder().decode(Movies.self, from: jsonData)
            completion(.success(result))
        } else {
            completion(.failure(MockError.mockError))
        }
    }
    
    func getUpcoming(parameters: [String : Any], completion: @escaping (Result<Movies, Error>) -> Void) {
        if let response = response {
            let jsonData = response.data(using: .utf8)!
            let result = try! JSONDecoder().decode(Movies.self, from: jsonData)
            completion(.success(result))
        } else {
            completion(.failure(MockError.mockError))
        }
    }
    
    func getMovieDetail(id: Int, parameters: [String : Any], completion: @escaping (Result<Movie, Error>) -> Void) {
        if let response = response {
            let jsonData = response.data(using: .utf8)!
            let result = try! JSONDecoder().decode(Movie.self, from: jsonData)
            completion(.success(result))
        } else {
            completion(.failure(MockError.mockError))
        }
    }
    
    func getMovieReview(id: Int, parameters: [String : Any], completion: @escaping (Result<Reviews, Error>) -> Void) {
        if let response = response {
            let jsonData = response.data(using: .utf8)!
            let result = try! JSONDecoder().decode(Reviews.self, from: jsonData)
            completion(.success(result))
        } else {
            completion(.failure(MockError.mockError))
        }
    }
    
    func getMovieVideo(id: Int, parameters: [String : Any], completion: @escaping (Result<Videos, Error>) -> Void) {
        if let response = response {
            let jsonData = response.data(using: .utf8)!
            let result = try! JSONDecoder().decode(Videos.self, from: jsonData)
            completion(.success(result))
        } else {
            completion(.failure(MockError.mockError))
        }
    }
}
