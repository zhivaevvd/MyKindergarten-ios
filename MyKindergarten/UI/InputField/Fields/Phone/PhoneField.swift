//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation
import InputMask
import UIKit

// MARK: - PhoneField

public final class PhoneField: InputField, MaskedTextFieldDelegateListener {
    // MARK: Lifecycle

    public init(
        colorStyle: InputFieldColorStyle = InputFieldColorStyles.default,
        placeholder: String = "",
        leftMargin: CGFloat = 0,
        rightMargin: CGFloat = 0,
        cornerRadius: CGFloat = 8
    ) {
        defer {
            prefix = "+7 "
        }
        super.init(
            colorStyle: colorStyle,
            leftMargin: leftMargin,
            rightMargin: rightMargin,
            placeholder: placeholder.isEmpty ? prefix : placeholder
        )
        textInput.delegate = phoneFieldMaskedDelegate
        phoneFieldMaskedDelegate.listener = self
        textInput.keyboardType = .phonePad
        layer.cornerRadius = cornerRadius
        phoneFieldMaskedDelegate.put(text: prefix, into: textInput)
    }

    // MARK: Public

    public var prefix: String = "+7 " {
        didSet {
            innerText.send(prefix)
        }
    }

    override public func setText(_ text: String) {
        super.setText(text)
        phoneFieldMaskedDelegate.put(text: text, into: textInput)
    }

    override public func updateState(with text: String) {
        textInputTC.priority = UILayoutPriority(rawValue: text.isEmpty ? 250 : 750)
        let change: (inout InputFieldState) -> Void = text.isEmpty || (text == prefix && !(titleLabel.text ?? "").isEmpty) ?
            { $0.remove(.hasText); $0.insert(.isEmpty) } :
            { $0.remove(.isEmpty); $0.insert(.hasText) }
        updateCurrentState(change)
    }

    // MARK: Internal

    override func _apply(uiProperties: InputFieldUIProperties) {
        textFieldContainer.backgroundColor = uiProperties.containerColor
        textFieldContainer.layer.borderWidth = 1
        textFieldContainer.layer.borderColor = uiProperties.containerBorderColor.cgColor
        textInput.tintColor = uiProperties.cursorColor
        switch uiProperties.placeholderPosition {
        case .topTitle:
            titleLabelTopConstraint?.constant = titlePosition
            titleLabelShouldChangeStyleForTop()
            textInput.isHidden = false
        case .emptyCenter:
            titleLabelTopConstraint?.constant = placeholderPosition
            titleLabelShouldChangeStyleForCenter()
            textInput.isHidden = true
        }
    }

    // MARK: Private

    private var phoneFieldMaskedDelegate = PhoneMaskedDelegate() // swiftlint:disable:this weak_delegate
}

// MARK: MaskedTextFieldDelegateListener

public extension PhoneField {
    func textField(_ textField: UITextField, didFillMandatoryCharacters _: Bool, didExtractValue _: String) {
        guard let text = textField.text else {
            return
        }
        if !textField.isFirstResponder, prefix.contains(text) {
            innerText.send(prefix)
        } else {
            innerText.send(text)
        }
    }
}
