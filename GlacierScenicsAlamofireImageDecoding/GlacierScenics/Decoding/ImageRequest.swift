//
//  ImageRequest.swift
//  GlacierScenics
//
//  Created by Todd Kramer on 9/22/16.
//  Copyright © 2016 Todd Kramer. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ImageRequest {

    var decodeOperation: Operation?
    var request: DataRequest

    init(request: DataRequest) {
        self.request = request
    }

    func cancel() {
        decodeOperation?.cancel()
        request.cancel()
    }

}
