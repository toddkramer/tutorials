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

class PhotosDataManager {
    
    static let sharedManager = PhotosDataManager()
    private var photos = [GlacierScenic]()

    let decoder = ImageDecoder()
    let photoCache = AutoPurgingImageCache(
        memoryCapacity: 100 * 1024 * 1024,
        preferredMemoryUsageAfterPurge: 60 * 1024 * 1024
    )
    
    //MARK: - Read Data
    
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

    //MARK: - Image Downloading
    
    func getNetworkImage(urlString: String, completion: (UIImage? -> Void)) -> (ImageRequest) {
        let queue = decoder.queue.underlyingQueue
        let request = Alamofire.request(.GET, urlString)
        let imageRequest = ImageRequest(request: request)
        imageRequest.request.response(
            queue: queue,
            responseSerializer: Request.imageResponseSerializer(),
            completionHandler: { response in
                guard let image = response.result.value else {
                    completion(nil)
                    return
                }
                let decodeOperation = self.decodeImage(image, completion: { (image) -> Void in
                    completion(image)
                    self.cacheImage(image, urlString: urlString)
                })
                imageRequest.decodeOperation = decodeOperation
            }
        )
        return imageRequest
    }

    func decodeImage(image: UIImage, completion: (UIImage -> Void)) -> DecodeOperation {
        let decodeOperation = DecodeOperation(image: image, decoder: self.decoder, completion: completion)
        self.decoder.queue.addOperation(decodeOperation)
        return decodeOperation
    }
    
    //MARK: - Image Caching

    func cacheImage(image: Image, urlString: String) {
        photoCache.addImage(image, withIdentifier: urlString)
    }

    func cachedImage(urlString: String) -> Image? {
        return photoCache.imageWithIdentifier(urlString)
    }
    
}
