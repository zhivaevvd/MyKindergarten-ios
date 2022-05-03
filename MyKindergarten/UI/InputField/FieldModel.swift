//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Combine
import Foundation

public struct FieldModel {
    // MARK: Lifecycle

    public init(
        validator: Validatable,
        value: CurrentValueSubject<String?, Never> = .init(nil),
        error: PassthroughSubject<String?, Never> = .init(),
        emptyErrorText: String? = L10n.Auth.wrongField
    ) {
        self.validator = validator
        self.value = value
        self.error = error
        self.emptyErrorText = emptyErrorText
    }

    // MARK: Public

    public let validator: Validatable
    public var value: CurrentValueSubject<String?, Never> = .init(nil)
    public var error: PassthroughSubject<String?, Never> = .init()
    public let emptyErrorText: String?

    public var fieldValue: String? {
        value.value
    }

    public var uFieldValue: String {
        value.value ?? ""
    }

    public func setValue(_ string: String?) {
        value.value = string
        error.send(nil)
    }

    @discardableResult
    public func validate(emptyCheck: Bool = true, notifyError: Bool = true) -> Bool {
        guard !uFieldValue.isEmpty || !emptyCheck else {
            if notifyError {
                error.send(emptyErrorText)
            }
            return false
        }
        let stringError = validator.validate(uFieldValue)
        if notifyError {
            error.send(stringError)
        }
        return stringError == nil
    }
}
