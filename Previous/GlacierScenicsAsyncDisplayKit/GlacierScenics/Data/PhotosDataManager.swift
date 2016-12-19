//
//  PhotosDataManager.swift
//  GlacierScenics
//
//  Created by Todd Kramer on 1/30/16.
//  Copyright © 2016 Todd Kramer. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import AsyncDisplayKit

class PhotosDataManager: NSObject {
    
    static let sharedManager = PhotosDataManager()
    private var photos = [GlacierScenic]()

    let photoCache = AutoPurgingImageCache(
        memoryCapacity: 100 * 1024 * 1024,
        preferredMemoryUsageAfterPurge: 60 * 1024 * 1024
    )
    
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

    func cacheImage(url: String, image: Image) {
        photoCache.addImage(image, withIdentifier: url)
    }
    
    func cachedImage(url: String) -> Image? {
        return photoCache.imageWithIdentifier(url)
    }
    
    func dataPath() -> String {
        return NSBundle.mainBundle().pathForResource("GlacierScenics", ofType: "plist")!
    }
    
}

extension PhotosDataManager: ASImageDownloaderProtocol {
    func downloadImageWithURL(URL: NSURL, callbackQueue: dispatch_queue_t?, downloadProgressBlock: ((CGFloat) -> Void)?, completion: ((CGImage?, NSError?) -> Void)?) -> AnyObject? {
        let request = Alamofire.request(.GET, URL.absoluteString).responseImage { (response) -> Void in
            guard let image = response.result.value else {
                completion?(nil, nil)
                return
            }
            self.cacheImage(URL.absoluteString, image: image)
            completion?(image.CGImage, nil)
        }
        return request
    }

    func cancelImageDownloadForIdentifier(downloadIdentifier: AnyObject?) {
        if let request = downloadIdentifier where request is Request {
            (request as! Request).cancel()
        }
    }
}

extension PhotosDataManager: ASImageCacheProtocol {
    func fetchCachedImageWithURL(URL: NSURL?, callbackQueue: dispatch_queue_t?, completion: (CGImage?) -> Void) {
        if let url = URL, cachedImage = cachedImage(url.absoluteString) {
            completion(cachedImage.CGImage)
            return
        }
        completion(nil)
    }
}
