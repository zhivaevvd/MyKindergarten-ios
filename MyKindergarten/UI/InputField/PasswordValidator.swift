//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation

public enum PasswordValidator: Validatable {
    case common

    // MARK: Public

    public func validate(_ value: String?) -> String? {
        (value?.count ?? 0) >= 6 ? nil : L10n.Auth.wrongField
    }
}
