//
//  AttributedTextNode.swift
//  GlacierScenics
//
//  Created by Todd Kramer on 2/14/16.
//  Copyright © 2016 Todd Kramer. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class AttributedTextNode: ASTextNode {

    func configure(text: String, size: CGFloat, color: UIColor = UIColor.whiteColor(), textAlignment: NSTextAlignment = .Left) {
        let mutableString = NSMutableAttributedString(string: text)
        let range = NSMakeRange(0, text.characters.count)
        mutableString.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(size), range: range)
        mutableString.addAttribute(NSForegroundColorAttributeName, value: color, range: range)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textAlignment
        mutableString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: range)
        attributedString = mutableString
    }

}
