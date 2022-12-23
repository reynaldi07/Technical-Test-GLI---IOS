//
//  MockHomeViewModel.swift
//  movie_app_iosTests
//
//  Created by Reynaldi Pamungkas on 23/12/22.
//

import Foundation
@testable import movie_app_ios

class MockHomeViewModel: HomeViewModelProtocol {
    var isSuccessGetUpcomingMovies = true
    
    var isSuccessGetNowPlayingMovies = true
    
    var errorMessage: String?
    
    var onBack: (() -> Void)?
    
    func back() {
        onBack?()
    }
    
    var nowPlayingMovies: Movies?
    
    var nowPlayingList: [Movie] = []
    
    var didFinishGetNowPlayingMovies: ((String?) -> Void)?
    
    func getNowPlayingMovies() {
        let JSON = DummyJsonResponse.ApiResponse.Movie.moviesResponse
        let jsonData = JSON.data(using: .utf8)!
        let response = try! JSONDecoder().decode(Movies.self, from: jsonData)
        if isSuccessGetNowPlayingMovies {
            nowPlayingMovies = response
            nowPlayingList = response.results ?? []
            didFinishGetNowPlayingMovies?("")
        } else {
            didFinishGetNowPlayingMovies?(MockError.mockError.localizedDescription)
        }
    }
    
    var upcomingMovies: Movies?
    
    var upcomingList: [Movie] = []
    
    var didFinishGetUpcomingMovies: ((String?) -> Void)?
    
    func getUpcomingMovies() {
        let JSON = DummyJsonResponse.ApiResponse.Movie.moviesResponse
        let jsonData = JSON.data(using: .utf8)!
        let response = try! JSONDecoder().decode(Movies.self, from: jsonData)
        if isSuccessGetUpcomingMovies {
            upcomingMovies = response
            upcomingList = response.results ?? []
            didFinishGetNowPlayingMovies?("")
        } else {
            didFinishGetNowPlayingMovies?(MockError.mockError.localizedDescription)
        }
    }
    
    var currentPageNowPlaying: Int = 1
    
    var currentPageUpcoming: Int = 1
}
