//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

public extension UIStackView {
    @inlinable
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach {
            addArrangedSubview($0)
        }
    }

    @inlinable
    func removeArrangedSubviews(_ views: [UIView]) {
        views.forEach {
            $0.removeFromSuperview()
        }
    }

    @inlinable
    func removeAllArrangedSubviews() {
        removeArrangedSubviews(arrangedSubviews)
    }
}
