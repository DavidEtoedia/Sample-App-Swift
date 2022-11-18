//
//  photo_model.swift
//  Sample-App-Swift
//
//  Created by Inyene Etoedia on 14/11/2022.
//

import Foundation


struct PhotoStruct : Identifiable, Codable {
    let id : String?
    let created_at : String?
    let updated_at : String?
    let promoted_at : String?
    let width : Int?
    let height : Int?
    let color : String?
    let blur_hash : String?
    let description : String?
    let alt_description : String?
    let urls : Urls?
//    let links : Links?
//    let likes : Int?
//    let liked_by_user : Bool?
//    let current_user_collections : [String]?
//    let sponsorship : Sponsorship?
//    let topic_submissions : Topic_submissions?
    let user : User?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case promoted_at = "promoted_at"
        case width = "width"
        case height = "height"
        case color = "color"
        case blur_hash = "blur_hash"
        case description = "description"
        case alt_description = "alt_description"
        case urls = "urls"
        case links = "links"
//        case likes = "likes"
//        case liked_by_user = "liked_by_user"
//        case current_user_collections = "current_user_collections"
//        case sponsorship = "sponsorship"
//        case topic_submissions = "topic_submissions"
        case user = "user"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        promoted_at = try values.decodeIfPresent(String.self, forKey: .promoted_at)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        blur_hash = try values.decodeIfPresent(String.self, forKey: .blur_hash)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        alt_description = try values.decodeIfPresent(String.self, forKey: .alt_description)
         urls = try values.decodeIfPresent(Urls.self, forKey: .urls)
//        links = try values.decodeIfPresent(Links.self, forKey: .links)
//        likes = try values.decodeIfPresent(Int.self, forKey: .likes)
//        liked_by_user = try values.decodeIfPresent(Bool.self, forKey: .liked_by_user)
//        current_user_collections = try values.decodeIfPresent([String].self, forKey: .current_user_collections)
//        sponsorship = try values.decodeIfPresent(Sponsorship.self, forKey: .sponsorship)
//        topic_submissions = try values.decodeIfPresent(Topic_submissions.self, forKey: .topic_submissions)
        
        user = try values.decodeIfPresent(User.self, forKey: .user) ?? values.decode(User.self, forKey: .user)
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container =  encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(created_at, forKey: .created_at)
        try container.encode(updated_at, forKey: .updated_at)
        try container.encode(promoted_at, forKey: .promoted_at)
        try container.encode(width, forKey: .width)
        try container.encode(height, forKey: .height)
        try container.encode(color, forKey: .color)
        try container.encode(blur_hash, forKey: .blur_hash)
        try container.encode(description, forKey: .description)
        try container.encode(alt_description, forKey: .alt_description)
        try container.encode(alt_description, forKey: .urls)
       
    }

}


struct Insect: Codable {
    let insectId: Int
    let name: String
    let isHelpful: Bool

    enum CodingKeys: String, CodingKey {
        case insectId = "insect_id"
        case name
        case details
    }

    enum DetailsCodingKeys: String, CodingKey {
        case isHelpful = "is_helpful"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        insectId = try container.decode(Int.self, forKey: .insectId)
        name = try container.decode(String.self, forKey: .name)
        let details = try container.nestedContainer(keyedBy: DetailsCodingKeys.self, forKey: .details)
        isHelpful = try details.decode(Bool.self, forKey: .isHelpful)

    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(insectId, forKey: .insectId)
        try container.encode(name.uppercased(), forKey: .name)
        var details = container.nestedContainer(keyedBy: DetailsCodingKeys.self, forKey: .details)
        try details.encode(isHelpful, forKey: .isHelpful)
    }
}
