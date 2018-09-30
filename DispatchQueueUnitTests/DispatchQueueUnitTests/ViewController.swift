
//  Copyright © 2018 Todd Kramer. All rights reserved.

import UIKit

protocol Dispatching: class {

    func async(_ block: @escaping () -> Void)

}

extension DispatchQueue: Dispatching {

    func async(_ block: @escaping () -> Void) {
        async(group: nil, execute: block)
    }

}

protocol ImageRequesting {

    func requestImage(withURL url: URL, completion: @escaping (UIImage?) -> Void)

}

extension ImageRequester: ImageRequesting {}

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    static let defaultBackgroundQueue = DispatchQueue(label: "com.app.ImageQueue", qos: .userInitiated, attributes: .concurrent)

    var imageRequester: ImageRequesting?
    var mainQueue: Dispatching?
    var backgroundQueue: Dispatching?

    func configure(withImageRequester imageRequester: ImageRequesting? = ImageRequester(),
                   mainQueue: Dispatching = DispatchQueue.main,
                   backgroundQueue: Dispatching = defaultBackgroundQueue) {
        self.imageRequester = imageRequester
        self.mainQueue = mainQueue
        self.backgroundQueue = backgroundQueue
    }

    func loadImage(withURL url: URL) {
        backgroundQueue?.async { [weak self] in
            self?.imageRequester?.requestImage(withURL: url) { image in
                self?.mainQueue?.async {
                    self?.imageView.image = image
                }
            }
        }
    }

}

