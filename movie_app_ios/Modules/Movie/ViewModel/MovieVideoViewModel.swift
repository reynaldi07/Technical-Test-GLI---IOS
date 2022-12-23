//
//  MovieVideoViewModel.swift
//  movie_app_ios
//
//  Created by Reynaldi Pamungkas on 22/12/22.
//

import Foundation

protocol MovieVideoViewModelProtocol {
    var errorMessage: String? { get set }
    var onBack: (() -> Void)? { get set }
    func back()
    var videos: Videos? { get set }
    var videoList: [Video] { get set }
    var didFinishGetVideo: ((_ error: String?) -> Void)? { get set }
    func getMovieVideo(id: Int)
}

class MovieVideoViewModel : MovieVideoViewModelProtocol {
    var service: MovieServiceProtocol
    
    init(service: MovieServiceProtocol) {
        self.service = service
    }
    
    var errorMessage: String?
    
    var onBack: (() -> Void)?
    
    func back() {
        onBack?()
    }
    
    var videos: Videos?
    
    var videoList: [Video] = []
    
    var didFinishGetVideo: ((String?) -> Void)?
    
    func getMovieVideo(id: Int) {
        let parameters: [String : Any] =
        [
            "api_key": Constants().getApiKey(),
            "language": "en-US"
        ]
        DispatchQueue.main.async {
            self.service.getMovieVideo(id: id, parameters: parameters) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.videos = response
                    self?.videoList.append(contentsOf: response.results ?? [])
                    self?.didFinishGetVideo?(nil)
                case .failure(let error):
                    self?.didFinishGetVideo?(error.localizedDescription)
                }
            }
        }
    }
}
