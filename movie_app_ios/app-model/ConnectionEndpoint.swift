//
//  ConnectionEndpoint.swift
//  movie_app_ios
//
//  Created by Reynaldi Pamungkas on 21/12/22.
//

import Foundation

public enum ConnectionEndpoint {
    case getNowPlaying
    case getUpcoming
    case getMovieDetail(id: Int)
    case getMovieReview(id: Int)
    case getMovieVideo(id: Int)
    
    var value: String {
        switch self {
        case .getNowPlaying: return "3/movie/now_playing"
        case .getUpcoming: return "3/movie/upcoming"
        case .getMovieDetail(let id): return "3/movie/\(id)"
        case .getMovieReview(let id): return "3/movie/\(id)/reviews"
        case .getMovieVideo(let id): return "3/movie/\(id)/videos"
        }
    }
}

extension URL {
    static func construct(_ endpoint: ConnectionEndpoint, queries: [String: Any] = [:]) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/" + endpoint.value
        components.queryItems = queries.isEmpty ? nil : queries
            .compactMapValues({
                if let value = $0 as? String {
                    return value
                } else {
                    return "\($0)"
                }
            })
            .map({ URLQueryItem(name: $0.key, value: $0.value) })
        return components.url
    }
}
