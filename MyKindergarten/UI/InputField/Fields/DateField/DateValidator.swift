//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation

public enum DateValidator: Validatable {
    case common

    // MARK: Public

    public func validate(_ value: String?) -> String? {
        let datePattern = #"^\d{2}[\/.]\d{2}[\/.]\d{4}$"#
        let check = value?.range(of: datePattern, options: .regularExpression) != nil
        return check ? nil : L10n.Common.invalidDate
    }

    public func checkDate(string: String?, _ condition: ((Date) -> Bool)?) -> String? {
        guard validate(string) == nil,
              let condition = condition,
              let date = DateFormatter().configure(with: { $0.dateFormat = "dd.MM.yyyy" }).date(from: string ?? "")
        else {
            return L10n.Common.invalidDate
        }
        return condition(date) ? nil : L10n.Common.invalidDate
    }
}
