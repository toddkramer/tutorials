
//  Copyright © 2018 Todd Kramer. All rights reserved.

final class Repository: Codable {

    let id: Int
    let name: String
    let description: String?
    let starCount: Int

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case starCount = "stargazers_count"
    }

}
