//
//  profile_image.swift
//  Sample-App-Swift
//
//  Created by Inyene Etoedia on 14/11/2022.
//

import Foundation

struct Profile_image : Codable {
    let small : String?
    let medium : String?
    let large : String?

    enum CodingKeys: String, CodingKey {

        case small = "small"
        case medium = "medium"
        case large = "large"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        small = try values.decodeIfPresent(String.self, forKey: .small)
        medium = try values.decodeIfPresent(String.self, forKey: .medium)
        large = try values.decodeIfPresent(String.self, forKey: .large)
    }
    
    func encode(to encoder: Encoder) throws {
        var container =  encoder.container(keyedBy: CodingKeys.self)
        try container.encode(small, forKey: .small)
        try container.encode(medium, forKey: .medium)
        try container.encode(large, forKey: .large)
        
    }

}
