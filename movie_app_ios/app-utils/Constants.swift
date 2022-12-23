//
//  Constants.swift
//  movie_app_ios
//
//  Created by Reynaldi Pamungkas on 21/12/22.
//

import Foundation
struct Constants {
    func getApiKey() -> String {
        return "c8f6ce9a00896969a96546e69386a31b"
    }
    
    func getBaseUrlImage() -> String {
        return "https://image.tmdb.org/t/p/w500"
    }
    
    func getBaseUrlYoutubeEmbed() -> String {
        return "https://www.youtube.com/embed/"
    }
    
    struct Segue {
        static let goToMovieDetailSegue = "goToMovieDetail"
        static let goToReviewSegue = "goToReview"
        static let goToVideoSegue = "goToVideo"
    }
}
