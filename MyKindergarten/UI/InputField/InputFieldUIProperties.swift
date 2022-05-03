//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

public struct InputFieldUIProperties {
    // MARK: Lifecycle

    public init(
        placeholderPosition: InputFieldPlaceholderPosition,
        containerColor: UIColor,
        containerBorderColor: UIColor,
        containerBorderWidth: CGFloat = 0,
        cursorColor: UIColor
    ) {
        self.placeholderPosition = placeholderPosition
        self.containerColor = containerColor
        self.containerBorderColor = containerBorderColor
        self.containerBorderWidth = containerBorderWidth
        self.cursorColor = cursorColor
    }

    // MARK: Public

    public let placeholderPosition: InputFieldPlaceholderPosition
    public let containerColor: UIColor
    public let containerBorderColor: UIColor
    public var containerBorderWidth: CGFloat = 0
    public let cursorColor: UIColor
}
