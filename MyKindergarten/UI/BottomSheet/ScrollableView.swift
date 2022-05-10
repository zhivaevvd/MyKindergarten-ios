//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

// MARK: - ScrollableView

public protocol ScrollableView: UIView {
    var scrollView: UIScrollView? { get }
}

// MARK: - UIView + ScrollableView

extension UIView: ScrollableView {}

public extension ScrollableView where Self: UIView {
    var scrollView: UIScrollView? { subviews.first as? UIScrollView }
}
