
//  Copyright © 2018 Todd Kramer. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configureRootViewController()
        return true
    }

    func configureRootViewController() {
        let path = "https://upload.wikimedia.org/wikipedia/commons/7/7a/Apple-swift-logo.png"
        guard let rootViewController = window?.rootViewController as? ViewController,
            let url = URL(string: path) else { return }
        rootViewController.configure()
        rootViewController.loadImage(withURL: url)
    }

}

