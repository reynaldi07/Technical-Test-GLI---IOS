//
//  MovieService.swift
//  movie_app_ios
//
//  Created by Reynaldi Pamungkas on 21/12/22.
//

import Foundation

protocol MovieServiceProtocol {
    func getNowPlaying(parameters: [String : Any], completion: @escaping(Result<Movies, Error>) -> Void)
    func getUpcoming(parameters: [String : Any], completion: @escaping(Result<Movies, Error>) -> Void)
    func getMovieDetail(id: Int, parameters: [String : Any], completion: @escaping(Result<Movie, Error>) -> Void)
    func getMovieReview(id: Int, parameters: [String : Any], completion: @escaping(Result<Reviews, Error>) -> Void)
    func getMovieVideo(id: Int, parameters: [String : Any], completion: @escaping(Result<Videos, Error>) -> Void)
}

class MovieService: MovieServiceProtocol {
    func getNowPlaying(parameters: [String : Any], completion: @escaping (Result<Movies, Error>) -> Void) {
        ConnectionService.shared.request(.get, .getNowPlaying, parameters: parameters, responseType: Movies.self) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func getUpcoming(parameters: [String : Any], completion: @escaping (Result<Movies, Error>) -> Void) {
        ConnectionService.shared.request(.get, .getUpcoming, parameters: parameters, responseType: Movies.self) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func getMovieDetail(id: Int, parameters: [String : Any], completion: @escaping (Result<Movie, Error>) -> Void) {
        ConnectionService.shared.request(.get, .getMovieDetail(id: id), parameters: parameters, responseType: Movie.self) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func getMovieReview(id: Int, parameters: [String : Any], completion: @escaping (Result<Reviews, Error>) -> Void) {
        ConnectionService.shared.request(.get, .getMovieReview(id: id), parameters: parameters, responseType: Reviews.self) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func getMovieVideo(id: Int, parameters: [String : Any], completion: @escaping (Result<Videos, Error>) -> Void) {
        ConnectionService.shared.request(.get, .getMovieVideo(id: id), parameters: parameters, responseType: Videos.self) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
