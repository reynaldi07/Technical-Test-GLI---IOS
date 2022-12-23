//
//  NowPlayingUIViewControllerTest.swift
//  movie_app_iosTests
//
//  Created by Reynaldi Pamungkas on 23/12/22.
//

import Foundation
@testable import movie_app_ios
import Quick
import Nimble

final class NowPlayingUIViewControllerTest: QuickSpec {
    override func spec() {
        var sut: NowPlayingUIViewController!
        var viewModel: MockHomeViewModel!
        
        beforeEach {
            viewModel = MockHomeViewModel()
            sut = NowPlayingUIViewController.init(viewModel: viewModel)
            sut.view.layoutIfNeeded()
        }
        
        describe("Upcoming Movie Controller") {
            it("sut is not nil") {
                sut.viewDidLoad()
                expect(sut).toNot(beNil())
            }
            it("list upcoming movie") {
                sut.viewDidLoad()
                viewModel.getNowPlayingMovies()
                let indexPath = IndexPath(row: 0, section: 0)
                let cell = (sut.movieCollection.dataSource?.collectionView(sut.movieCollection, cellForItemAt: indexPath) ?? UICollectionViewCell()) as! MovieCollectionViewCell
                cell.setupUI(movie: Movie(adult: true, backdropPath: "Backdrop", belongsToCollection: BelongsToCollection(id: 1, name: "Name", posterPath: "Poster", backdropPath: "Backdrop"), budget: 100000, genres: [Genre(id: 1, name: "Action")], homepage: "Home Page", id: 1, imdbID: "1", originalLanguage: "en", originalTitle: "Title", overview: "Nice", popularity: 9.0, posterPath: "poster", productionCompanies: [ProductionCompany(id: 2, logoPath: "logo", name: "name", originCountry: "country")], productionCountries: [ProductionCountry(iso3166_1: "iso", name: "name")], releaseDate: "010101", revenue: 1000, runtime: 100, spokenLanguages: [SpokenLanguage(englishName: "Name", iso639_1: "iso", name: "name")], status: "active", tagline: "tagline", title: "title", video: false, voteAverage: 4.0, voteCount: 1000))
                expect(cell).toNot(beNil())
                expect(sut.movieCollection.numberOfItems(inSection: 0)).toEventually(equal(20))
            }
        }
    }
}
