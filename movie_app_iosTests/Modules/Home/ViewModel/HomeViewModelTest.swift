//
//  HomeViewModelTest.swift
//  movie_app_iosTests
//
//  Created by Reynaldi Pamungkas on 22/12/22.
//

import Foundation
@testable import movie_app_ios
import Quick
import Nimble

final class HomeViewModelTest: QuickSpec {
    var error: String?
    
    override func spec() {
        var errorMessage: String?
        var isDidFinishedGetNowPlayingMovies = false
        var isDidFinishedGetUpcomingMovies = false
        var isBack = false
        var viewModel: HomeViewModel!
        var service: MockMovieService!
        
        beforeEach {
            service = MockMovieService()
            viewModel = HomeViewModel.init(service: service)
            
            func stubOnFinishedGetNowPlayingMovies(_ error: String?) {
                errorMessage = error
                isDidFinishedGetNowPlayingMovies = true
            }
            
            func stubOnFinishedGetUpcomingMovies(_ error: String?) {
                errorMessage = error
                isDidFinishedGetUpcomingMovies = true
            }
            func stubBack() {
                isBack = true
            }
            
            viewModel.didFinishGetNowPlayingMovies = stubOnFinishedGetNowPlayingMovies
            viewModel.didFinishGetUpcomingMovies = stubOnFinishedGetUpcomingMovies
            viewModel.onBack = stubBack
        }
        
        describe("Moview View Model") {
            it("view model is not nil") {
                expect(viewModel).toNot(beNil())
            }
            
            it("success get now playing movies") {
                service.response = DummyJsonResponse.ApiResponse.Movie.moviesResponse
                viewModel.getNowPlayingMovies()
                expect(isDidFinishedGetNowPlayingMovies).toEventually(beTrue())
                expect(errorMessage).toEventually(beEmpty())
                expect(viewModel.nowPlayingMovies).toEventuallyNot(beNil())
                expect(viewModel.nowPlayingList).toEventuallyNot(beNil())
            }
            
            it("failed get now playing movies") {
                viewModel.getNowPlayingMovies()
                expect(isDidFinishedGetNowPlayingMovies).toEventually(beTrue())
                expect(errorMessage).toEventually(equal(MockError.mockError.localizedDescription))
            }
            
            it("success get upcoming movies") {
                service.response = DummyJsonResponse.ApiResponse.Movie.moviesResponse
                viewModel.getUpcomingMovies()
                expect(isDidFinishedGetUpcomingMovies).toEventually(beTrue())
                expect(errorMessage).toEventually(beEmpty())
                expect(viewModel.upcomingMovies).toEventuallyNot(beNil())
                expect(viewModel.upcomingList).toEventuallyNot(beNil())
            }
            
            it("failed get upcoming movies") {
                viewModel.getUpcomingMovies()
                expect(isDidFinishedGetUpcomingMovies).toEventually(beTrue())
                expect(errorMessage).toEventually(equal(MockError.mockError.localizedDescription))
            }
            
            it("test func onBack called") {
                viewModel.back()
                expect(isBack).to(equal(true))
            }
        }
    }
}
