//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

public struct StyledButtonStateColor {
    public let enabledColor: UIColor
    public let disabledColor: UIColor
    public let pressedColor: UIColor

    public static func plain(_ color: UIColor) -> StyledButtonStateColor {
        StyledButtonStateColor(enabledColor: color, disabledColor: color, pressedColor: color)
    }

    public static func difficult(_ enabledColor: UIColor, _ disabledColor: UIColor) -> StyledButtonStateColor {
        StyledButtonStateColor(enabledColor: enabledColor, disabledColor: disabledColor, pressedColor: enabledColor)
    }
}
