
//  Copyright © 2018 Todd Kramer. All rights reserved.

import UIKit

struct KeyboardPresentationAttributes {

    let beginFrame: CGRect
    let endFrame: CGRect
    let animationDuration: Double
    let animationOptions: UIViewAnimationOptions

    init?(userInfo: [AnyHashable: Any]?) {
        guard
            let beginFrame = (userInfo?[UIKeyboardFrameBeginUserInfoKey] as AnyObject).cgRectValue,
            let endFrame = (userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue,
            let animationDuration = (userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue,
            let animationCurve = (userInfo?[UIKeyboardAnimationCurveUserInfoKey] as AnyObject).uintValue
            else { return nil }
        self.beginFrame = beginFrame
        self.endFrame = endFrame
        self.animationDuration = animationDuration
        self.animationOptions = UIViewAnimationOptions(rawValue: animationCurve << 16)
    }
}

protocol KeyboardObserverDelegate: class {

    func keyboardObserver(_ keyboardObserver: KeyboardObserver, didShowKeyboardWithAttributes attributes: KeyboardPresentationAttributes)
    func keyboardObserver(_ keyboardObserver: KeyboardObserver, didHideKeyboardWithAttributes attributes: KeyboardPresentationAttributes)

}

class KeyboardObserver {

    weak var delegate: KeyboardObserverDelegate?

    init(delegate: KeyboardObserverDelegate?) {
        self.delegate = delegate
        addObservers()
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(toggleKeyboard), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toggleKeyboard), name: .UIKeyboardWillHide, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func toggleKeyboard(for notification: Notification) {
        guard let attributes = KeyboardPresentationAttributes(userInfo: notification.userInfo) else { return }
        switch notification.name {
        case .UIKeyboardWillShow:
            delegate?.keyboardObserver(self, didShowKeyboardWithAttributes: attributes)
        case .UIKeyboardWillHide:
            delegate?.keyboardObserver(self, didHideKeyboardWithAttributes: attributes)
        default:
            break
        }
    }

}
