//
//  MovieDetailViewModel.swift
//  movie_app_ios
//
//  Created by Reynaldi Pamungkas on 22/12/22.
//

import Foundation

protocol MovieDetailViewModelProtocol {
    var errorMessage: String? { get set }
    var onBack: (() -> Void)? { get set }
    func back()
    var dataMovie: Movie? {get set }
    var didFinishGetDetailMovie: ((_ error: String?) -> Void)? { get set }
    func getDetailMovie(id: Int)
}

class MovieDetailViewModel: MovieDetailViewModelProtocol {
    var service: MovieServiceProtocol
    
    init(service: MovieServiceProtocol) {
        self.service = service
    }
    
    var errorMessage: String?
    
    var onBack: (() -> Void)?
    
    func back() {
        onBack?()
    }
    
    var dataMovie: Movie?
    
    var didFinishGetDetailMovie: ((String?) -> Void)?
    
    func getDetailMovie(id: Int) {
        let parameters: [String : Any] =
        [
            "api_key": Constants().getApiKey(),
            "language": "en-US"
        ]
        DispatchQueue.main.async {
            self.service.getMovieDetail(id: id, parameters: parameters) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.dataMovie = response
                    self?.didFinishGetDetailMovie?("")
                case .failure(let error):
                    self?.didFinishGetDetailMovie?(error.localizedDescription)
                }
            }
        }
    }
}
