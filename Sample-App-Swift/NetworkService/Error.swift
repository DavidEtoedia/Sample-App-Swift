//
//  Error.swift
//  Sample-App-Swift
//
//  Created by Inyene Etoedia on 17/11/2022.
//

import Foundation

enum ApiError : Error {
    case DecodingError
    case errorCode(Int)
    case unknown
}

extension ApiError : LocalizedError {
    var errorDescription: String? {
        switch self{
        case.DecodingError:
            return "An Error Occurred While Decoding"
        case.errorCode( let code):
            return "An Error Occured with an Error \(code)"
        case .unknown:
          return "an Unknown Error occurred"
        }
    }
}

enum ValidationError: LocalizedError {
    case missingName

    var errorDescription: String? {
        switch self {
        case .missingName:
            return "Name is a required field."
        }
    }
}
