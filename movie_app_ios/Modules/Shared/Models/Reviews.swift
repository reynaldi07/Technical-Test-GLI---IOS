//
//  Reviews.swift
//  movie_app_ios
//
//  Created by Reynaldi Pamungkas on 22/12/22.
//

import Foundation

struct Reviews: Codable {
    let id, page: Int?
    let results: [Review]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
