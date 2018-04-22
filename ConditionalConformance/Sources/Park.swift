
//  Created by Todd Kramer on 4/22/18.
//  Copyright © 2018 Todd Kramer. All rights reserved.

import Foundation

public final class Park: Codable {

    public let id: String
    public let name: String
    public let location: String

    public init(id: String, name: String, location: String) {
        self.id = id
        self.name = name
        self.location = location
    }

}
