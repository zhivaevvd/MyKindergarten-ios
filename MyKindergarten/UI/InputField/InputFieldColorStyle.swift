//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation

// MARK: - InputFieldColorStyle

public protocol InputFieldColorStyle {
    func uiProperties(by state: InputFieldState, currentValue: String?) -> InputFieldUIProperties
}

public extension InputFieldColorStyle {
    func uiProperties(by state: InputFieldState, currentValue: String? = nil) -> InputFieldUIProperties {
        uiProperties(by: state, currentValue: currentValue)
    }
}
