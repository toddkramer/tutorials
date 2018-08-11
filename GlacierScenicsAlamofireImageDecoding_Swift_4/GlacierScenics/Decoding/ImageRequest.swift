//
//  ImageRequest.swift
//  GlacierScenics
//
//  Created by Todd Kramer on 9/22/16. Updated 8/11/18.
//  Copyright © 2018 Todd Kramer. All rights reserved.
//

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
