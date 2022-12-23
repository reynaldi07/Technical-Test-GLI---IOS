//
//  MovieDetailViewModelTest.swift
//  movie_app_iosTests
//
//  Created by Reynaldi Pamungkas on 23/12/22.
//

import Foundation
@testable import movie_app_ios
import Nimble
import Quick

final class MovieDetailViewModelTest: QuickSpec {
    var error: String?
    
    override func spec() {
        var errorMessage: String?
        var isDidFinishedGetDetail = false
        var isBack = false
        var viewModel: MovieDetailViewModel!
        var service: MockMovieService!
        
        beforeEach {
            service = MockMovieService()
            viewModel = MovieDetailViewModel.init(service: service)
            
            func stubOnFinishedGetDetail(_ error: String?) {
                errorMessage = error
                isDidFinishedGetDetail = true
            }
            
            func stubBack() {
                isBack = true
            }
            
            viewModel.didFinishGetDetailMovie = stubOnFinishedGetDetail
            viewModel.onBack = stubBack
        }
        
        describe("Movie Detail View Model") {
            it("view model is not nil") {
                expect(viewModel).toNot(beNil())
            }
            
            it("success get movie detail") {
                service.response = DummyJsonResponse.ApiResponse.Movie.movieDetailResponse
                viewModel.getDetailMovie(id: 7001)
                expect(isDidFinishedGetDetail).toEventually(beTrue())
                expect(errorMessage).toEventually(beNil())
                expect(viewModel.dataMovie).toEventuallyNot(beNil())
            }
            
            it("failed get movie detail") {
                viewModel.getDetailMovie(id: 7001)
                expect(isDidFinishedGetDetail).toEventually(beTrue())
                expect(errorMessage).toEventually(equal(MockError.mockError.localizedDescription))
            }
            
            it("test func onBack called") {
                viewModel.back()
                expect(isBack).to(equal(true))
            }
        }
    }
}
