//
//  endpoint.swift
//  Sample-App-Swift
//
//  Created by Inyene Etoedia on 17/11/2022.
//

import Foundation

enum Endpoint: CustomStringConvertible {
    case getPhotos
    var description: String {
        switch self {
        case .getPhotos:
            return "https://api.unsplash.com/photos/?client_id=CK5_SZXnwCO7ORvuSV9E8UvYRi9Crl9soXY2t9Hwtgo"
        }
    }
}

//enum Audience: String, Printable {
//    case Public = "Public"
//    case Friends = "Friends"
//    case Private = "Private"
//
//    var description: String {
//        return self.rawValue
//    }
//}




//enum ValidationError: LocalizedError {
//    case missingName
//
//    var errorDescription: String? {
//        switch self {
//        case .missingName:
//            return "Name is a required field."
//        }
//    }
//}
