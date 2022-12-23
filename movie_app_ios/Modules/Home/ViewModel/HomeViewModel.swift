//
//  HomeViewModel.swift
//  movie_app_ios
//
//  Created by Reynaldi Pamungkas on 21/12/22.
//

import Foundation

protocol HomeViewModelProtocol {
    var errorMessage: String? { get set }
    var onBack: (() -> Void)? { get set }
    func back()
    var nowPlayingMovies: Movies? {get set }
    var nowPlayingList: [Movie] {get set}
    var didFinishGetNowPlayingMovies: ((_ error: String?) -> Void)? { get set }
    func getNowPlayingMovies()
    var upcomingMovies: Movies? {get set}
    var upcomingList: [Movie] {get set}
    var didFinishGetUpcomingMovies: ((_ error: String?) -> Void)? { get set }
    func getUpcomingMovies()
    var currentPageNowPlaying: Int {get set}
    var currentPageUpcoming: Int {get set}
}

class HomeViewModel: HomeViewModelProtocol {
    var service: MovieServiceProtocol
    
    init(service: MovieServiceProtocol) {
        self.service = service
    }
    
    var currentPageNowPlaying: Int = 1
    
    var currentPageUpcoming: Int = 1
    
    var errorMessage: String?
    
    var onBack: (() -> Void)?
    
    func back() {
        onBack?()
    }
    
    var nowPlayingMovies: Movies?
    
    var nowPlayingList: [Movie] = []
    
    var upcomingMovies: Movies?
    
    var upcomingList: [Movie] = []
    
    var didFinishGetNowPlayingMovies: ((String?) -> Void)?
    
    var didFinishGetUpcomingMovies: ((String?) -> Void)?
    
    func getNowPlayingMovies() {
        let parameters: [String : Any] =
        [
            "api_key": Constants().getApiKey(),
            "language": "en-US",
            "page": currentPageNowPlaying
        ]
        DispatchQueue.main.async {
            self.service.getNowPlaying(parameters: parameters) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.nowPlayingMovies = response
                    self?.nowPlayingList.append(contentsOf: response.results ?? [])
                    self?.didFinishGetNowPlayingMovies?("")
                case .failure(let error):
                    self?.didFinishGetNowPlayingMovies?(error.localizedDescription)
                }
            }
        }
    }
    
    func getUpcomingMovies() {
        let parameters: [String : Any] =
        [
            "api_key": Constants().getApiKey(),
            "language": "en-US",
            "page": currentPageUpcoming
        ]
        DispatchQueue.main.async {
            self.service.getUpcoming(parameters: parameters) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.upcomingMovies = response
                    self?.upcomingList.append(contentsOf: response.results ?? [])
                    self?.didFinishGetUpcomingMovies?("")
                case .failure(let error):
                    self?.didFinishGetUpcomingMovies?(error.localizedDescription)
                }
            }
        }
    }
}
