//
//  DecodeOperation.swift
//  GlacierScenics
//
//  Created by Todd Kramer on 9/22/16.
//  Copyright © 2016 Todd Kramer. All rights reserved.
//

import Foundation
import UIKit

class DecodeOperation: Operation {

    let image: UIImage
    let completion: (UIImage) -> Void

    init(image: UIImage, completion: @escaping (UIImage) -> Void) {
        self.image = image
        self.completion = completion
    }

    override func main() {
        if isCancelled { return }
        let decodedImage = decode(image)
        if isCancelled { return }

        OperationQueue.main.addOperation {
            self.completion(decodedImage)
        }
    }

    func decode(_ image: UIImage) -> UIImage {
        guard let cgImage = image.cgImage else { return image }
        let size = CGSize(width: cgImage.width, height: cgImage.height)
        guard let context = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: 0, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue) else { return image }
        context.draw(cgImage, in: CGRect(origin: .zero, size: size))
        guard let decodedImage = context.makeImage() else { return image }
        return UIImage(cgImage: decodedImage, scale: image.scale, orientation: image.imageOrientation)
    }

}
