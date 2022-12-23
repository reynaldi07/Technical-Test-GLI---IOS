//
//  HomeViewControllerTest.swift
//  movie_app_iosTests
//
//  Created by Reynaldi Pamungkas on 23/12/22.
//

import Foundation
@testable import movie_app_ios
import Quick
import Nimble

final class HomeViewControllerTest: QuickSpec {
    override func spec() {
        var sut: HomeViewController!
        
        beforeEach {
            sut = HomeViewController()
            sut.view.layoutIfNeeded()
        }
        
        describe("Home Controller") {
            it("sut is not nil") {
                sut.viewDidLoad()
                sut.prepare(for: UIStoryboardSegue.init(identifier: Constants.Segue.goToMovieDetailSegue, source: UIViewController(), destination: MovieDetailViewController()), sender: Movie.self)
                expect(sut).toNot(beNil())
            }
        }
    }
}
