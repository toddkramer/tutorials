//
//  ImageRequest.swift
//  GlacierScenics
//
//  Created by Todd Kramer on 2/27/16.
//  Copyright © 2016 Todd Kramer. All rights reserved.
//

import UIKit
import Alamofire

class ImageRequest {

    var decodeOperation: NSOperation?
    var request: Request

    init(request: Request) {
        self.request = request
    }

    func cancel() {
        decodeOperation?.cancel()
        request.cancel()
    }
    
}
