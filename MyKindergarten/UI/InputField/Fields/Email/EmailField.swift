//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation
import UIKit

public final class EmailField: InputField {
    override public init(
        colorStyle: InputFieldColorStyle = InputFieldColorStyles.default,
        leftMargin: CGFloat = 16,
        rightMargin: CGFloat = 16,
        placeholder: String = L10n.Auth.email
    ) {
        super.init(colorStyle: colorStyle, leftMargin: leftMargin, rightMargin: rightMargin, placeholder: placeholder)
        textInput.keyboardType = .emailAddress
        textInput.placeholder = placeholder
        textInput.autocapitalizationType = .none
        textInput.autocorrectionType = .no
    }
}
