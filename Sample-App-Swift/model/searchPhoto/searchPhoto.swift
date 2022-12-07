//
//  searchPhoto.swift
//  Sample-App-Swift
//
//  Created by Inyene Etoedia on 30/11/2022.
//

import Foundation
struct SearchPhoto : Decodable {
    let total : Int?
    let total_pages : Int?
    let results : [Resultss]?

    enum CodingKeys: String, CodingKey {

        case total = "total"
        case total_pages = "total_pages"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
        results = try values.decodeIfPresent([Resultss].self, forKey: .results)
    }

}
