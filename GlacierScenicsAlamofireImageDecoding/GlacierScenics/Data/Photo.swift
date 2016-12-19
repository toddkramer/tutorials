//
//  Photo.swift
//  GlacierScenics
//
//  Created by Todd Kramer on 1/30/16.
//  Copyright © 2016 Todd Kramer. All rights reserved.
//

struct Photo {

    let name: String
    let url: String

    init(info: [String: Any]) {
        self.name = info["name"] as! String
        self.url = info["imageURL"] as! String
    }

}
