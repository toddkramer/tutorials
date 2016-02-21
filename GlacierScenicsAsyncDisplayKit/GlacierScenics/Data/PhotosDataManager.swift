//
//  PhotosDataManager.swift
//  GlacierScenics
//
//  Created by Todd Kramer on 1/30/16.
//  Copyright © 2016 Todd Kramer. All rights reserved.
//

import UIKit

class PhotosDataManager {
    
    static let sharedManager = PhotosDataManager()
    private var photos = [GlacierScenic]()
    
    func allPhotos() -> [GlacierScenic] {
        if !photos.isEmpty { return photos }
        guard let data = NSArray(contentsOfFile: dataPath()) as? [NSDictionary] else { return photos }
        for photoInfo in data {
            let name = photoInfo["name"] as! String
            let urlString = photoInfo["imageURL"] as! String
            let glacierScenic = GlacierScenic(name: name, photoURLString: urlString)
            photos.append(glacierScenic)
        }
        return photos
    }
    
    func dataPath() -> String {
        return NSBundle.mainBundle().pathForResource("GlacierScenics", ofType: "plist")!
    }
    
}
