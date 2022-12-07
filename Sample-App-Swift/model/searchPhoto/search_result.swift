//
//  search_result.swift
//  Sample-App-Swift
//
//  Created by Inyene Etoedia on 30/11/2022.
//

import Foundation
struct Resultss : Identifiable,Decodable {
    let id : String?
    let description : String?
    let alt_description : String?
    let urls : Urls?
    let likes : Int?
    let liked_by_user : Bool?
    let user : User?
//    let tags : [String]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
//        case created_at = "created_at"
//        case updated_at = "updated_at"
//        case promoted_at = "promoted_at"
//        case width = "width"
//        case height = "height"
//        case color = "color"
//        case blur_hash = "blur_hash"
        case description = "description"
        case alt_description = "alt_description"
        case urls = "urls"
        case likes = "likes"
        case liked_by_user = "liked_by_user"
        case user = "user"
//        case tags = "tags"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
//        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
//        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
//        promoted_at = try values.decodeIfPresent(String.self, forKey: .promoted_at)
//        width = try values.decodeIfPresent(Int.self, forKey: .width)
//        height = try values.decodeIfPresent(Int.self, forKey: .height)
//        color = try values.decodeIfPresent(String.self, forKey: .color)
//        blur_hash = try values.decodeIfPresent(String.self, forKey: .blur_hash)
        description = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
        alt_description = try values.decodeIfPresent(String.self, forKey: .alt_description) ?? ""
        urls = try values.decodeIfPresent(Urls.self, forKey: .urls)

        likes = try values.decodeIfPresent(Int.self, forKey: .likes) ?? 0
        liked_by_user = try values.decodeIfPresent(Bool.self, forKey: .liked_by_user) ?? false
    
        user = try values.decodeIfPresent(User.self, forKey: .user)
//        tags = try values.decodeIfPresent([String].self, forKey: .tags) ?? []
    }

}

