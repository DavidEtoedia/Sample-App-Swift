//
//  photo_details_model.swift
//  Sample-App-Swift
//
//  Created by Inyene Etoedia on 18/11/2022.
//

import Foundation

struct PhotoDetails : Codable {
    let id : String?
    let description : String?
    let alt_description : String?
    let urls : Urls?
    let likes : Int?
//    let current_user_collections : [String]?
//    let topic_submissions : Topic_submissions?
    let user : User?
//    let exif : Exif?
//    let location : Location?
//    let tags : [String]?
//    let tags_preview : [String]?
    let downloads : Int?
    let related_collections : Related_collections?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case description = "description"
        case alt_description = "alt_description"
        case urls = "urls"
        case likes = "likes"
//        case current_user_collections = "current_user_collections"
//        case topic_submissions = "topic_submissions"
        case user = "user"
//        case exif = "exif"
//        case location = "location"
//        case tags = "tags"
//        case tags_preview = "tags_preview"
        case downloads = "downloads"
        case related_collections = "related_collections"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        description = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
        alt_description = try values.decodeIfPresent(String.self, forKey: .alt_description) ?? ""
        urls = try values.decodeIfPresent(Urls.self, forKey: .urls)
        likes = try values.decodeIfPresent(Int.self, forKey: .likes)
//        current_user_collections = try values.decodeIfPresent([String].self, forKey: .current_user_collections)
//        topic_submissions = try values.decodeIfPresent(Topic_submissions.self, forKey: .topic_submissions)
        user = try values.decodeIfPresent(User.self, forKey: .user)
//        exif = try values.decodeIfPresent(Exif.self, forKey: .exif)
//        location = try values.decodeIfPresent(Location.self, forKey: .location)
//        tags = try values.decodeIfPresent([String].self, forKey: .tags)
//        tags_preview = try values.decodeIfPresent([String].self, forKey: .tags_preview)
        downloads = try values.decodeIfPresent(Int.self, forKey: .downloads)
        related_collections = try values.decodeIfPresent(Related_collections.self, forKey: .related_collections)
    }
    
    func encode(to encoder: Encoder) throws {
        var container =  encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(alt_description, forKey: .alt_description)
        try container.encode(description, forKey: .description)
        try container.encode(urls, forKey: .urls)
        try container.encode(likes, forKey: .likes)
//        try container.encode(current_user_collections, forKey: .current_user_collections)
//        try container.encode(topic_submissions, forKey: .topic_submissions)
        try container.encode(user, forKey: .user)
//        try container.encode(exif, forKey: .exif)
//        try container.encode(location, forKey: .location)
//        try container.encode(tags, forKey: .tags)
//        try container.encode(tags_preview, forKey: .tags_preview)
        try container.encode(downloads, forKey: .downloads)
//        try container.encode(related_collections, forKey: .related_collections)
      
    }

}
