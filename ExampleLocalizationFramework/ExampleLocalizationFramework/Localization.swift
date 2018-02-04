
//  Copyright © 2018 Todd Kramer. All rights reserved.

import Foundation

extension Bundle {

    private static let bundleID = "com.toddkramer.ExampleLocalizationFramework"
    
    static var module: Bundle {
        return Bundle(identifier: bundleID) ?? .main
    }

}

extension String {

    func localized(withComment comment: String = "") -> String {
        return NSLocalizedString(self, bundle: Bundle.module, comment: comment)
    }

}

public enum Localization {

    public static let login = "login".localized()
    public static let emailAddress = "email address".localized()
    public static let password = "password".localized()

}
