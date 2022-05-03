//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation

public enum EmailValidator: Validatable {
    case common

    // MARK: Public

    public func validate(_ value: String?) -> String? {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,50}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let check = emailPred.evaluate(with: value ?? "")
        return check ? nil : L10n.Auth.wrongField
    }
}
