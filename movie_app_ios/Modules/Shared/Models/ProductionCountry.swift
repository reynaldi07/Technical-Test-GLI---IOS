//
//  ProductionCountry.swift
//  movie_app_ios
//
//  Created by Reynaldi Pamungkas on 22/12/22.
//

import Foundation

struct ProductionCountry: Codable {
    let iso3166_1, name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}
