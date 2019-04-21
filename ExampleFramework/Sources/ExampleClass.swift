
//  Copyright © 2018 Todd Kramer. All rights reserved.

import Foundation

#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit
    public typealias Color = UIColor
#elseif os(OSX)
    import Cocoa
    public typealias Color = NSColor
#endif

public class ExampleClass {
    
    public static func getRandomColor() -> Color {
        let colors = [Color.red, Color.orange, Color.yellow, Color.green, Color.blue]
        let randomIndex = Int(arc4random_uniform(UInt32(colors.count)))
        return colors[randomIndex]
    }
    
}
