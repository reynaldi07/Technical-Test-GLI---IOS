//
//  MockError.swift
//  movie_app_iosTests
//
//  Created by Reynaldi Pamungkas on 22/12/22.
//

import Foundation
@testable import movie_app_ios
enum MockError: Error {
    case mockError
}
extension MockError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .mockError:
            return NSLocalizedString(
                "Response is unavailable",
                comment: "MockError"
            )
        }
    }
}
