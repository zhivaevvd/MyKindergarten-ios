//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation

public struct InputFieldState: OptionSet {
    // MARK: Lifecycle

    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }

    // MARK: Public

    public static let focused = InputFieldState(rawValue: 1 << 0)
    public static let nonFocused = InputFieldState(rawValue: 1 << 1)
    public static let hasText = InputFieldState(rawValue: 1 << 2)
    public static let isEmpty = InputFieldState(rawValue: 1 << 3)
    public static let hasError = InputFieldState(rawValue: 1 << 4)

    public let rawValue: UInt8
}
