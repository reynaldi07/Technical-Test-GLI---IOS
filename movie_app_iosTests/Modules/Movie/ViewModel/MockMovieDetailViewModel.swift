//
//  MockMovieDetailViewModel.swift
//  movie_app_iosTests
//
//  Created by Reynaldi Pamungkas on 23/12/22.
//

import Foundation
@testable import movie_app_ios

class MockMovieDetailViewModel: MovieDetailViewModelProtocol {
    var isSuccessGetDetail = true
    
    var errorMessage: String?
    
    var onBack: (() -> Void)?
    
    func back() {
        onBack?()
    }
    
    var dataMovie: Movie?
    
    var didFinishGetDetailMovie: ((String?) -> Void)?
    
    func getDetailMovie(id: Int) {
        let JSON = DummyJsonResponse.ApiResponse.Movie.movieDetailResponse
        let jsonData = JSON.data(using: .utf8)!
        let response = try! JSONDecoder().decode(Movie.self, from: jsonData)
        if isSuccessGetDetail {
            dataMovie = response
            didFinishGetDetailMovie?("")
        } else {
            didFinishGetDetailMovie?(MockError.mockError.localizedDescription)
        }
    }
}
