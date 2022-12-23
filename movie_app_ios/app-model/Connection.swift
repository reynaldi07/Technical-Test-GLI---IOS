//
//  Connection.swift
//  movie_app_ios
//
//  Created by Reynaldi Pamungkas on 14/12/22.
//

import Foundation

public final class Connection {

    public struct ResponseMessage: Decodable {
        public let en: String
        public let id: String

        public var localized: String {
            return Locale.current.language.languageCode?.identifier.hasPrefix("en") == true ? en : id
        }
    }
    
    public struct MyCustomError: Error {
        let message: String
        
    }
    public struct Response<T: Decodable>: Decodable {
        public var status: Int
        public var data: T?
        public var message: ResponseMessage?
        public var meta: MetaModel?

        enum Keys: String, CodingKey {
            case status, code, data, message, meta
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: Keys.self)
            if let status = try container.decodeIfPresent(Int.self, forKey: .status) {
                self.status = status
            } else if let code = try container.decodeIfPresent(Int.self, forKey: .code) {
                self.status = code
            } else {
                self.status = 0
            }
            self.data = try container.decodeIfPresent(T.self, forKey: .data)
            self.message = try container.decodeIfPresent(ResponseMessage.self, forKey: .message)
            self.meta = try container.decodeIfPresent(MetaModel.self, forKey: .meta)
        }
    }

    public static var isUATEnv: Bool = false

    public enum Method: String {
        case get, post, patch, put, delete
    }
    public struct MetaModel: Codable {
        let count: Int?

        enum CodingKeys: String, CodingKey {
            case count
        }
    }
}


extension Connection.MyCustomError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString(message, comment: "")
    }
}

