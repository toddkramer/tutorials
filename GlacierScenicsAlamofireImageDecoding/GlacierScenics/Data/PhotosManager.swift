//
//  PhotosManager.swift
//  GlacierScenics
//
//  Created by Todd Kramer on 1/30/16.
//  Copyright © 2016 Todd Kramer. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension UInt64 {

    func megabytes() -> UInt64 {
        return self * 1024 * 1024
    }

}

class PhotosManager {

    static let shared = PhotosManager()

    private var dataPath: String {
        return Bundle.main.path(forResource: "GlacierScenics", ofType: "plist")!
    }

    lazy var photos: [Photo] = {
        var photos = [Photo]()
        guard let data = NSArray(contentsOfFile: self.dataPath) as? [[String: Any]] else { return photos }
        for info in data {
            let photo = Photo(info: info)
            photos.append(photo)
        }
        return photos
    }()

    let decodeQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.underlyingQueue = DispatchQueue(label: "com.GlacierScenics.imageDecoder", attributes: .concurrent)
        queue.maxConcurrentOperationCount = 4
        return queue
    }()

    let imageCache = AutoPurgingImageCache(
        memoryCapacity: UInt64(100).megabytes(),
        preferredMemoryUsageAfterPurge: UInt64(60).megabytes()
    )

    //MARK: - Image Downloading

    func retrieveImage(for url: String, completion: @escaping (UIImage) -> Void) -> ImageRequest {
        let queue = decodeQueue.underlyingQueue
        let request = Alamofire.request(url, method: .get)
        let imageRequest = ImageRequest(request: request)
        let serializer = DataRequest.imageResponseSerializer()
        imageRequest.request.response(queue: queue, responseSerializer: serializer) { response in
            guard let image = response.result.value else { return }
            imageRequest.decodeOperation = self.decode(image) { image in
                completion(image)
                self.cache(image, for: url)
            }
        }
        return imageRequest
    }

    //MARK: - Image Caching

    func cache(_ image: Image, for url: String) {
        imageCache.add(image, withIdentifier: url)
    }

    func cachedImage(for url: String) -> Image? {
        return imageCache.image(withIdentifier: url)
    }

    //MARK: - Image Decoding

    func decode(_ image: UIImage, completion: @escaping (UIImage) -> Void) -> DecodeOperation {
        let operation = DecodeOperation(image: image, completion: completion)
        decodeQueue.addOperation(operation)
        return operation
    }

}
