/*
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Results : Decodable, Identifiable {
    let id : String?
    let title : String?
    let description : String?
    let published_at : String?
    let last_collected_at : String?
    let updated_at : String?
    let curated : Bool?
    let featured : Bool?
    let total_photos : Int?
//    let private : Bool?
//    let share_share_key : String?
//    let tags : [Tags]?
//    let links : Links?
//    let user : User?
//    let cover_photo : Cover_photo?
    let preview_photos : [Preview_photos]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case description = "description"
        case published_at = "published_at"
        case last_collected_at = "last_collected_at"
        case updated_at = "updated_at"
        case curated = "curated"
        case featured = "featured"
        case total_photos = "total_photos"
//        case private = "private"
//        case share_key = "share_key"
//        case tags = "tags"
//        case links = "links"
//        case user = "user"
//        case cover_photo = "cover_photo"
        case preview_photos = "preview_photos"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        published_at = try values.decodeIfPresent(String.self, forKey: .published_at)
        last_collected_at = try values.decodeIfPresent(String.self, forKey: .last_collected_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        curated = try values.decodeIfPresent(Bool.self, forKey: .curated)
        featured = try values.decodeIfPresent(Bool.self, forKey: .featured)
        total_photos = try values.decodeIfPresent(Int.self, forKey: .total_photos)
//        private = try values.decodeIfPresent(Bool.self, forKey: .private)
//        share_key = try values.decodeIfPresent(String.self, forKey: .share_key)
//        tags = try values.decodeIfPresent([Tags].self, forKey: .tags)
//        links = try values.decodeIfPresent(Links.self, forKey: .links)
//        user = try values.decodeIfPresent(User.self, forKey: .user)
//        cover_photo = try values.decodeIfPresent(Cover_photo.self, forKey: .cover_photo)
        preview_photos = try values.decodeIfPresent([Preview_photos].self, forKey: .preview_photos)
    }

}
