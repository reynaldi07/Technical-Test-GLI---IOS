//
//  MovieReviewViewModel.swift
//  movie_app_ios
//
//  Created by Reynaldi Pamungkas on 22/12/22.
//

import Foundation

protocol MovieReviewViewModelProtocol {
    var errorMessage: String? { get set }
    var onBack: (() -> Void)? { get set }
    func back()
    var reviews: Reviews? { get set }
    var reviewList: [Review] { get set }
    var didFinishGetReview: ((_ error: String?) -> Void)? { get set }
    func getMovieReview(id: Int)
    var currentPage: Int {get set}
}

class MovieReviewViewModel : MovieReviewViewModelProtocol {
    var service: MovieServiceProtocol
    
    init(service: MovieServiceProtocol) {
        self.service = service
    }
    
    var currentPage: Int = 1
    
    var errorMessage: String?
    
    var onBack: (() -> Void)?
    
    func back() {
        onBack?()
    }
    
    var reviews: Reviews?
    
    var reviewList: [Review] = []
    
    var didFinishGetReview: ((String?) -> Void)?
    
    func getMovieReview(id: Int) {
        let parameters: [String : Any] =
        [
            "api_key": Constants().getApiKey(),
            "language": "en-US",
            "page": currentPage
        ]
        DispatchQueue.main.async {
            self.service.getMovieReview(id: id, parameters: parameters) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.reviews = response
                    self?.reviewList.append(contentsOf: response.results ?? [])
                    self?.didFinishGetReview?(nil)
                case .failure(let error):
                    self?.didFinishGetReview?(error.localizedDescription)
                }
            }
        }
    }
}
