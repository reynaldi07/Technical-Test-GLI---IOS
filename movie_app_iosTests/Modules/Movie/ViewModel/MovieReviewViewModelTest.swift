//
//  MovieReviewViewModelTest.swift
//  movie_app_iosTests
//
//  Created by Reynaldi Pamungkas on 23/12/22.
//

import Foundation
@testable import movie_app_ios
import Nimble
import Quick

final class MovieReviewViewModelTest: QuickSpec {
    var error: String?
    
    override func spec() {
        var errorMessage: String?
        var isDidFinishedGetReview = false
        var isBack = false
        var viewModel: MovieReviewViewModel!
        var service: MockMovieService!
        
        beforeEach {
            service = MockMovieService()
            viewModel = MovieReviewViewModel.init(service: service)
            
            func stubOnFinishedGetReview(_ error: String?) {
                errorMessage = error
                isDidFinishedGetReview = true
            }
            
            func stubBack() {
                isBack = true
            }
            
            viewModel.didFinishGetReview = stubOnFinishedGetReview
            viewModel.onBack = stubBack
        }
        
        describe("Movie Review View Model") {
            it("view model is not nil") {
                expect(viewModel).toNot(beNil())
            }
            
            it("success get movie review") {
                service.response = DummyJsonResponse.ApiResponse.Movie.movieReviewResponse
                viewModel.getMovieReview(id: 7001)
                expect(isDidFinishedGetReview).toEventually(beTrue())
                expect(errorMessage).toEventually(beNil())
                expect(viewModel.reviews).toEventuallyNot(beNil())
                expect(viewModel.reviewList).toEventuallyNot(beNil())
            }
            
            it("failed get movie review") {
                viewModel.getMovieReview(id: 7001)
                expect(isDidFinishedGetReview).toEventually(beTrue())
                expect(errorMessage).toEventually(equal(MockError.mockError.localizedDescription))
            }
            
            it("test func onBack called") {
                viewModel.back()
                expect(isBack).to(equal(true))
            }
        }
    }
}
