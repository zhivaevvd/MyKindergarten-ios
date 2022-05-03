//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

public class PaddingLabel: Label {
    public var insets: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)

    override public var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + insets.left + insets.right,
            height: size.height + insets.top + insets.bottom
        )
    }

    override public func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
}
