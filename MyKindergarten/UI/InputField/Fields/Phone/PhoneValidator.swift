//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation

public enum PhoneValidator: Validatable {
    case common

    // MARK: Public

    public func validate(_ value: String?) -> String? {
        let check = NSPredicate(format: "SELF MATCHES %@", "^([0-9]{11})$")
        return check.evaluate(with: value?.adaptedPhone ?? "") ? nil : L10n.Auth.wrongField
    }
}
