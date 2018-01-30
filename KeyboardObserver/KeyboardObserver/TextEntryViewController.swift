
//  Copyright © 2018 Todd Kramer. All rights reserved.

import UIKit

class TextEntryViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!

    var keyboardObserver: KeyboardObserver?
    let textViewPadding: CGFloat = 8

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTextView()
        keyboardObserver = KeyboardObserver(delegate: self)
    }

    func configureTextView() {
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
    }

}

// MARK: - Keyboard

extension TextEntryViewController: KeyboardObserverDelegate {

    func toggleKeyboard(with attributes: KeyboardPresentationAttributes) {
        UIView.animate(withDuration: attributes.animationDuration, delay: 0, options: attributes.animationOptions, animations: {
            self.textViewBottomConstraint.constant = attributes.endFrame.size.height + self.textViewPadding
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    func keyboardObserver(_ keyboardObserver: KeyboardObserver, didShowKeyboardWithAttributes attributes: KeyboardPresentationAttributes) {
        toggleKeyboard(with: attributes)
    }

    func keyboardObserver(_ keyboardObserver: KeyboardObserver, didHideKeyboardWithAttributes attributes: KeyboardPresentationAttributes) {
        toggleKeyboard(with: attributes)
    }

}
