//
//  MockMovieVideoViewModel.swift
//  movie_app_iosTests
//
//  Created by Reynaldi Pamungkas on 23/12/22.
//

import Foundation
@testable import movie_app_ios

class MockMovieVideoViewModel: MovieVideoViewModelProtocol {
    var isSuccessGetVideo = true
    
    var errorMessage: String?
    
    var onBack: (() -> Void)?
    
    func back() {
        onBack?()
    }
    
    var videos: Videos?
    
    var videoList: [Video] = []
    
    var didFinishGetVideo: ((String?) -> Void)?
    
    func getMovieVideo(id: Int) {
        let JSON = DummyJsonResponse.ApiResponse.Movie.movieVideoResponse
        let jsonData = JSON.data(using: .utf8)!
        let response = try! JSONDecoder().decode(Videos.self, from: jsonData)
        if isSuccessGetVideo {
            videos = response
            videoList = response.results ?? []
            didFinishGetVideo?("")
        } else {
            didFinishGetVideo?(MockError.mockError.localizedDescription)
        }
    }
}
