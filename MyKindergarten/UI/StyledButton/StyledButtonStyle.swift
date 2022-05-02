//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

public struct StyledButtonStyle {
    // MARK: Lifecycle

    public init(
        font: UIFont,
        disabledFont: UIFont,
        background: StyledButtonStateColor,
        text: StyledButtonStateColor,
        border: StyledButtonStateColor,
        borderWidth: CGFloat,
        cornerRadius: CGFloat,
        buttonHeight: CGFloat,
        loaderStyle: StyledButtonLoaderStyle
    ) {
        self.font = font
        self.disabledFont = disabledFont
        self.background = background
        self.text = text
        self.border = border
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
        self.buttonHeight = buttonHeight
        self.loaderStyle = loaderStyle
    }

    // MARK: Public

    public var font: UIFont
    public var disabledFont: UIFont
    public var background: StyledButtonStateColor
    public var text: StyledButtonStateColor
    public var border: StyledButtonStateColor
    public var borderWidth: CGFloat
    public var cornerRadius: CGFloat
    public var buttonHeight: CGFloat
    public var loaderStyle: StyledButtonLoaderStyle
}
