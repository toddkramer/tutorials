
//  Copyright © 2018 Todd Kramer. All rights reserved.

import UIKit

final class ImageRequester {

    let defaultSession = URLSession(configuration: .default)

    func requestImage(withURL url: URL, completion: @escaping (UIImage?) -> Void) {
        let dataTask = defaultSession.dataTask(with: url) { data, _, error in
            let image = self.serializeImage(with: data, error: error)
            completion(image)
        }
        dataTask.resume()
    }

    private func serializeImage(with data: Data?, error: Error?) -> UIImage? {
        if error != nil { return nil }
        guard let data = data, let image = UIImage(data: data) else { return nil }
        return image
    }

}
