//
//  MovieVideoViewModelTest.swift
//  movie_app_iosTests
//
//  Created by Reynaldi Pamungkas on 23/12/22.
//

import Foundation
@testable import movie_app_ios
import Quick
import Nimble

final class MovieVideoViewModelTest: QuickSpec {
    var error: String?
    
    override func spec() {
        var errorMessage: String?
        var isDidFinishedGetVideo = false
        var isBack = false
        var viewModel: MovieVideoViewModel!
        var service: MockMovieService!
        
        beforeEach {
            service = MockMovieService()
            viewModel = MovieVideoViewModel.init(service: service)
            
            func stubOnFinishedGetVideo(_ error: String?) {
                errorMessage = error
                isDidFinishedGetVideo = true
            }
            
            func stubBack() {
                isBack = true
            }
            
            viewModel.didFinishGetVideo = stubOnFinishedGetVideo
            viewModel.onBack = stubBack
        }
        
        describe("Movie Video View Model") {
            it("view model is not nil") {
                expect(viewModel).toNot(beNil())
            }
            
            it("success get movie video") {
                service.response = DummyJsonResponse.ApiResponse.Movie.movieVideoResponse
                viewModel.getMovieVideo(id: 7001)
                expect(isDidFinishedGetVideo).toEventually(beTrue())
                expect(errorMessage).toEventually(beNil())
                expect(viewModel.videos).toEventuallyNot(beNil())
                expect(viewModel.videoList).toEventuallyNot(beNil())
            }
            
            it("failed get movie video") {
                viewModel.getMovieVideo(id: 7001)
                expect(isDidFinishedGetVideo).toEventually(beTrue())
                expect(errorMessage).toEventually(equal(MockError.mockError.localizedDescription))
            }
            
            it("test func onBack called") {
                viewModel.back()
                expect(isBack).to(equal(true))
            }
        }
    }
}
