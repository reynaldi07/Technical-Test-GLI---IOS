//
//  MockMovieReviewViewModel.swift
//  movie_app_iosTests
//
//  Created by Reynaldi Pamungkas on 23/12/22.
//

import Foundation
@testable import movie_app_ios

class MockMovieReviewViewModel: MovieReviewViewModelProtocol {
    var isSuccessGetReview = true
    
    var errorMessage: String?
    
    var onBack: (() -> Void)?
    
    func back() {
        onBack?()
    }
    
    var reviews: Reviews?
    
    var reviewList: [Review] = []
    
    var didFinishGetReview: ((String?) -> Void)?
    
    func getMovieReview(id: Int) {
        let JSON = DummyJsonResponse.ApiResponse.Movie.movieReviewResponse
        let jsonData = JSON.data(using: .utf8)!
        let response = try! JSONDecoder().decode(Reviews.self, from: jsonData)
        if isSuccessGetReview {
            reviews = response
            reviewList = response.results ?? []
            didFinishGetReview?("")
        } else {
            didFinishGetReview?(MockError.mockError.localizedDescription)
        }
    }
    
    var currentPage: Int = 1
    
    
}
