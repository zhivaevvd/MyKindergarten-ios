//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation
import InputMask
import UIKit

@IBDesignable
public class PhoneMaskedDelegate: MaskedTextFieldDelegate {
    // MARK: Lifecycle

    override init() {
        super.init()
        primaryMaskFormat = "+7 ([000]) [000]-[00]-[00]"
        autocomplete = true
        autocompleteOnFocus = true
        autoskip = true
        rightToLeft = false
        affineFormats = []
        affinityCalculationStrategy = .prefix
        customNotations = []
        onMaskedTextChangedCallback = nil
    }

    // MARK: Open

    @discardableResult
    override open func put(text: String, into field: UITextField, autocomplete _: Bool? = nil) -> Mask.Result {
        super.put(text: text.maskedPhoneNumber, into: field, autocomplete: autocomplete)
    }

    override open func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let isDeletion = range.length > 0 && string.isEmpty
        let useAutocomplete = isDeletion ? false : autocomplete
        let useAutoskip = isDeletion ? autoskip : false
        let caretGravity: CaretString.CaretGravity =
            isDeletion ? .backward(autoskip: useAutoskip) : .forward(autocomplete: useAutocomplete)

        let updatedText: String = replaceCharacters(inText: textField.text ?? "", range: range, withCharacters: string)
        let caretPositionInt: Int = isDeletion ? range.location : range.location + string.count
        let caretPosition: String.Index = updatedText.startIndex(offsetBy: caretPositionInt)
        let text = CaretString(string: updatedText, caretPosition: caretPosition, caretGravity: caretGravity)

        let mask: Mask = pickMask(forText: text)
        let result: Mask.Result = mask.apply(toText: text)

        if string.digits.count >= 11 {
            textField.text = string.maskedPhoneNumber
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                (textField as UITextInput).caretPosition = result.formattedText.string.distanceFromStartIndex(
                    to: result.formattedText.caretPosition
                )
            }
            listener?.textField?(textField, didFillMandatoryCharacters: true, didExtractValue: string.maskedPhoneNumber)
        } else if string == "8", (textField.text ?? "").isEmpty {
            let replacingEightText = "+7 "
            textField.text = replacingEightText
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                (textField as UITextInput).caretPosition = result.formattedText.string.distanceFromStartIndex(
                    to: result.formattedText.caretPosition
                )
            }
            listener?.textField?(textField, didFillMandatoryCharacters: false, didExtractValue: replacingEightText)
        } else {
            textField.text = result.formattedText.string

            if atomicCursorMovement {
                (textField as UITextInput).caretPosition = result.formattedText.string.distanceFromStartIndex(
                    to: result.formattedText.caretPosition
                )
            } else {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                    (textField as UITextInput).caretPosition = result.formattedText.string.distanceFromStartIndex(
                        to: result.formattedText.caretPosition
                    )
                }
            }
            if let result = shouldChangeCharactersIn?(range, string) {
                return result
            }
            notifyOnMaskedTextChangedListeners(forTextField: textField, result: result)
        }
        return false
    }

    // MARK: Internal

    var shouldChangeCharactersIn: ((NSRange, String) -> Bool?)?
}
