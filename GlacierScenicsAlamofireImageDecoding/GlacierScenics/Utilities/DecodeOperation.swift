//
//  DecodeOperation.swift
//  GlacierScenics
//
//  Created by Todd Kramer on 2/27/16.
//  Copyright © 2016 Todd Kramer. All rights reserved.
//

import UIKit

class DecodeOperation: NSOperation {

    let image: UIImage
    let decoder: ImageDecoder
    let completion: (UIImage -> Void)

    init(image: UIImage, decoder: ImageDecoder, completion: (UIImage -> Void)) {
        self.image = image
        self.decoder = decoder
        self.completion = completion
    }

    override func main() {
        if cancelled {
            return
        }

        let decodedImage = decoder.decode(image)

        if cancelled {
            return
        }

        NSOperationQueue.mainQueue().addOperationWithBlock {
            self.completion(decodedImage)
        }
    }

}
