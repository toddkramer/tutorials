//
//  ImageDecoder.swift
//  GlacierScenics
//
//  Created by Todd Kramer on 2/27/16.
//  Copyright © 2016 Todd Kramer. All rights reserved.
//

import UIKit

enum ContentMode {
    case AspectFill
    case AspectFit
}

class ImageDecoder {

    let queue = NSOperationQueue()
    static let MaxImageSize = CGSize(width: CGFloat.max, height: CGFloat.max)
    static let DefaultContentMode: ContentMode = .AspectFill
    
    init() {
        let underlyingQueue = dispatch_queue_create("com.GlacierScenics.imageDecoder", DISPATCH_QUEUE_CONCURRENT)
        queue.underlyingQueue = underlyingQueue
        queue.maxConcurrentOperationCount = 4
    }

    func decode(image: UIImage, targetSize: CGSize = MaxImageSize, contentMode: ContentMode = DefaultContentMode) -> UIImage {
        let size = decodedSize(image.CGImage, targetSize: targetSize, contentMode: contentMode)
        guard let context = CGBitmapContextCreate(nil, Int(size.width), Int(size.height), 8, 0, CGColorSpaceCreateDeviceRGB(), CGImageAlphaInfo.None.rawValue) else { return image }
        CGContextDrawImage(context, CGRect(origin: CGPointZero, size: size), image.CGImage)
        guard let decodedImage = CGBitmapContextCreateImage(context) else { return image }
        return UIImage(CGImage: decodedImage, scale: image.scale, orientation: image.imageOrientation)
    }

    func decodedSize(image: CGImage?, targetSize: CGSize, contentMode: ContentMode) -> CGSize {
        let imageSize = CGSize(width: CGImageGetWidth(image), height: CGImageGetHeight(image))
        let horizontalScale = targetSize.width / imageSize.width
        let verticalScale = targetSize.height / imageSize.height
        let scale = contentMode == .AspectFill ? max(horizontalScale, verticalScale) : min(horizontalScale, verticalScale)
        let clampedScale: CGFloat = min(scale, 1)
        return CGSize(width: round(clampedScale * imageSize.width), height: round(clampedScale * imageSize.height))
    }
}
