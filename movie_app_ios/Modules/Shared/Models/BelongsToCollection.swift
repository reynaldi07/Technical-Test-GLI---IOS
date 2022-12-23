//
//  BelongsToCollection.swift
//  movie_app_ios
//
//  Created by Reynaldi Pamungkas on 22/12/22.
//

import Foundation

struct BelongsToCollection: Codable {
    let id: Int?
    let name, posterPath, backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
