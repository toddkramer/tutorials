
//  Copyright © 2018 Todd Kramer. All rights reserved.

final class Profile: Codable {

    let id: Int
    let name: String
    let blog: String
    let avatarURL: String

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case blog
        case avatarURL = "avatar_url"
    }

}
