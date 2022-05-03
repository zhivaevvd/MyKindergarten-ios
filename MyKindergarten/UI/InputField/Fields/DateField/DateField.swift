//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import InputMask
import UIKit

// MARK: - DateField

public final class DateField: InputField, MaskedTextFieldDelegateListener {
    // MARK: Lifecycle

    public init(
        colorStyle: InputFieldColorStyle = InputFieldColorStyles.default,
        placeholder: String = L10n.Common.bdate
    ) {
        super.init(colorStyle: colorStyle, placeholder: placeholder)
        textInput.delegate = maskedDelegate
        maskedDelegate.listener = self
        maskedDelegate.affineFormats = ["[00]{.}[00]{.}[0000]"]
        textInput.keyboardType = .numberPad
    }

    // MARK: Public

    override public func setText(_ text: String) {
        super.setText(text)
        maskedDelegate.put(text: text, into: textInput)
    }

    public func setDateText(_ date: Date) {
        let stringDate = DateFormatter.date(from: date)
        setText(stringDate)
    }

    public func setEditable(_ value: Bool) {
        isUserInteractionEnabled = value
        textInput.isUserInteractionEnabled = value
        textInput.textColor = value ? Asset.borderBlack.color : Asset.grayScaleMediumGrey.color
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

    private var maskedDelegate = MaskedTextFieldDelegate() // swiftlint:disable:this weak_delegate
}

// MARK: MaskedTextFieldDelegateListener

public extension DateField {
    func textField(_ textField: UITextField, didFillMandatoryCharacters _: Bool, didExtractValue _: String) {
        guard let text = textField.text else {
            return
        }
        innerText.send(text)
    }
}
