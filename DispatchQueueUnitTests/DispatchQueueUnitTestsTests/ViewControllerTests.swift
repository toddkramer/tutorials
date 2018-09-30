
//  Copyright © 2018 Todd Kramer. All rights reserved.

import XCTest
@testable import DispatchQueueUnitTests

class ViewControllerTests: XCTestCase {

    let imageRequester: ImageRequesting = MockImageRequester()
    let mainQueue: Dispatching = MockQueue()
    let backgroundQueue: Dispatching = MockQueue()

    let url = URL(string: "https://commons.wikimedia.org/wiki/File:Apple-swift-logo.png")!
    
    lazy var viewController: ViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateInitialViewController() as! ViewController
        viewController.configure(withImageRequester: imageRequester,
                                 mainQueue: mainQueue,
                                 backgroundQueue: backgroundQueue)
        UIApplication.shared.keyWindow?.rootViewController = viewController
        return viewController
    }()

    func testLoadImage() {
        XCTAssertNil(viewController.imageView.image)
        viewController.loadImage(withURL: url)
        XCTAssertNotNil(viewController.imageView.image)
    }
    
}

class MockImageRequester: ImageRequesting {

    func requestImage(withURL url: URL, completion: @escaping (UIImage?) -> Void) {
        let bundle = Bundle(for: ViewControllerTests.self)
        let url = bundle.url(forResource: "swift_logo", withExtension: "png")!
        let data = try! Data(contentsOf: url)
        let image = UIImage(data: data)!
        completion(image)
    }
}

class MockQueue: Dispatching {

    func async(_ block: @escaping () -> Void) {
        block()
    }

}
