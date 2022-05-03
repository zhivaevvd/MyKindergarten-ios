//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation
import UIKit

public class TextField: UITextField {
    public var isActionsEnabled = true

    public var becomeFRSideEffect: (() -> Void)?

    public var resignFRSideEffect: (() -> Void)?
    public var onEmptyBackward: (() -> Void)?

    public var onEveryBackward: (() -> Void)?

    public var currentText: String? {
        get {
            self.text
        }
        set {
            self.text = newValue
        }
    }

    override public func deleteBackward() {
        if (text ?? "").isEmpty {
            onEmptyBackward?()
        }
        onEveryBackward?()
        placeholder = "•"
        super.deleteBackward()
    }

    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        guard !isActionsEnabled else {
            return super.canPerformAction(action, withSender: sender)
        }
        let actions = [
            "delete:",
            "makeTextWritingDirectionRightToLeft:",
            "makeTextWritingDirectionLeftToRight",
        ].map {
            Selector($0)
        }
        return actions.contains(action) ? false : super.canPerformAction(action, withSender: sender)
    }

    override public func becomeFirstResponder() -> Bool {
        becomeFRSideEffect?()
        return super.becomeFirstResponder()
    }

    override public func resignFirstResponder() -> Bool {
        resignFRSideEffect?()
        return super.resignFirstResponder()
    }

    override public func caretRect(for position: UITextPosition) -> CGRect {
        var originalRect = super.caretRect(for: position)
        originalRect.size.height = 20
        return originalRect
    }
}
