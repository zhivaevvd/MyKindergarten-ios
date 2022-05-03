//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation

// MARK: - Validatable

public protocol Validatable {
    func validate(_ value: String?) -> String? // Throw string error description if validation failed
    // and nil if validation was success
}

// MARK: - EmptyValidator

public enum EmptyValidator: Validatable {
    case common

    // MARK: Public

    public func validate(_: String?) -> String? {
        nil
    }
}
