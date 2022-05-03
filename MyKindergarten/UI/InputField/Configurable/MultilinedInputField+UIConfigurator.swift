//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

public extension MultilinedInputField {
    var errorView: UIView {
        errorLabel
    }

    func handleError(text: String?) {
        errorLabel.text = text
        errorLabel.isHidden = text == nil
    }

    override var intrinsicContentSize: CGSize {
        UIView.layoutFittingCompressedSize
    }

    func configureLayout() {
        let contentStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [textFieldContainer, errorView])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.isUserInteractionEnabled = false
            stackView.spacing = fieldToError
            return stackView
        }()
        let wtConstraint = textFieldContainer.widthAnchor.constraint(equalTo: contentStackView.widthAnchor)
        wtConstraint.priority = UILayoutPriority(rawValue: 999)
        wtConstraint.isActive = true

        let weConstraint = errorView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor)
        weConstraint.priority = UILayoutPriority(rawValue: 999)
        weConstraint.isActive = true
        addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        let chConstraint = contentStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: fieldHeight)
        chConstraint.priority = UILayoutPriority(rawValue: 999)
        chConstraint.isActive = true

        textFieldContainer.addSubview(titleLabel)
        textFieldContainer.addSubview(textInput)

        titleLabel.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor, constant: leftMargin).isActive = true

        textInput.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor, constant: leftMargin).isActive = true
        textInput.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: -16).isActive = true

        textInputTC = textInput.topAnchor
            .constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 0)
        textInputTC.priority = UILayoutPriority(rawValue: 250)
        textInputTC.isActive = true

        let titleTConstraint = titleLabel.trailingAnchor
            .constraint(equalTo: textFieldContainer.trailingAnchor, constant: -rightMargin)
        titleTConstraint.priority = UILayoutPriority(rawValue: 999)
        titleTConstraint.isActive = true

        let textTConstraint = textInput.trailingAnchor
            .constraint(equalTo: textFieldContainer.trailingAnchor, constant: -rightMargin)
        textTConstraint.priority = UILayoutPriority(rawValue: 999)
        textTConstraint.isActive = true

        titleLabelTopConstraint = titleLabel.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: placeholderPosition)
        titleLabelTopConstraint.isActive = true
    }

    func configureTextInput() {
        textInput.translatesAutoresizingMaskIntoConstraints = false
        textInput.delegate = self
        textInput.textColor = Asset.grayScaleBlack.color
        textInput.textAlignment = .left
        textInput.font = inputTextFont

        textInput.textContainerInset = .zero
        textInput.isScrollEnabled = false
        textInput.textContainer.maximumNumberOfLines = 0
        textInput.textContainer.lineFragmentPadding = .zero
        textInput.textContainer.lineBreakMode = .byTruncatingMiddle

        textInput.autocapitalizationType = .sentences
        textInput.autocorrectionType = .no
        textInput.backgroundColor = .clear
        textInput.isHidden = true
        textInput.becomeFRSideEffect = { [unowned self] in
            becomeFRSideEffect?()
            updateStateOnBecomeFirstResponder()
        }
        textInput.resignFRSideEffect = { [unowned self] in
            updateStateOnResignFirstResponder()
        }
    }

    var fieldHeight: CGFloat {
        56
    }

    var textInputLineHeight: CGFloat {
        24
    }

    var fieldToError: CGFloat {
        4
    }

    var titlePosition: CGFloat {
        0
    }

    var placeholderPosition: CGFloat {
        16
    }

    func titleLabelShouldChangeStyleForTop() {
        titleLabel.textColor = .clear
    }

    func titleLabelShouldChangeStyleForCenter() {
        titleLabel.textColor = Asset.grayScaleMediumGrey.color
        titleLabel.font = placeholderFont
    }

    func setupErrorLabelProperties() {
        errorLabel.textColor = Asset.alertsDanger.color
        errorLabel.numberOfLines = 0
        errorLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
}
