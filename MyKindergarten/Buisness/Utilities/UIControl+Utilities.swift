//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

public extension UIControl {
    private static var closureSelectorStore: [UnsafeMutableRawPointer: () -> Void] = [:]

    private var currentAddress: UnsafeMutableRawPointer {
        Unmanaged.passUnretained(self).toOpaque()
    }

    private var action: (() -> Void)? {
        get { UIControl.closureSelectorStore[currentAddress] }
        set { UIControl.closureSelectorStore[currentAddress] = newValue }
    }

    @objc
    private func triggerActionHandler() {
        action?()
    }

    func setAction(for control: UIControl.Event = .touchUpInside, handler action: (() -> Void)? = nil) {
        guard let action = action else {
            return
        }
        self.action = action
        removeTarget(self, action: #selector(triggerActionHandler), for: control)
        addTarget(self, action: #selector(triggerActionHandler), for: control)
    }
}
