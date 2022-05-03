//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

public extension InputField {
    var errorView: UIView {
        errorLabel
    }

    func handleError(text: String?) {
        errorLabel.text = text
        errorLabel.isHidden = text == nil
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
        let textWConstr = textFieldContainer.widthAnchor.constraint(equalTo: contentStackView.widthAnchor)
        textWConstr.priority = UILayoutPriority(rawValue: 999)
        textWConstr.isActive = true

        let errorWConstr = errorView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor)
        errorWConstr.priority = UILayoutPriority(rawValue: 999)
        errorWConstr.isActive = true

        addSubview(contentStackView)

        contentStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 7).isActive = true

        let chConstr = contentStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: fieldHeight)
        chConstr.priority = UILayoutPriority(rawValue: 999)
        chConstr.isActive = true

        let tfConstr = textFieldContainer.heightAnchor.constraint(equalToConstant: fieldHeight)
        tfConstr.priority = UILayoutPriority(rawValue: 999)
        tfConstr.isActive = true
        textFieldContainer.addSubview(titleLabel)
        textFieldContainer.addSubview(textInput)

        titleLabel.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor, constant: leftMargin).isActive = true

        textInput.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor, constant: leftMargin).isActive = true
        textInput.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: -7).isActive = true

        textInputTC = textInput.topAnchor
            .constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 0)
        textInputTC.priority = UILayoutPriority(rawValue: 250)
        textInputTC.isActive = true

        let titleTConstr = titleLabel.trailingAnchor
            .constraint(equalTo: textFieldContainer.trailingAnchor, constant: -rightMargin)
        titleTConstr.priority = UILayoutPriority(rawValue: 999)
        titleTConstr.isActive = true

        let textInputTrailingConstr = textInput.trailingAnchor.constraint(
            equalTo: textFieldContainer.trailingAnchor,
            constant: -rightMargin
        )
        textInputTrailingConstr.priority = UILayoutPriority(rawValue: 999)
        textInputTrailingConstr.isActive = true

        titleLabelTopConstraint = titleLabel.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: placeholderPosition)
        titleLabelTopConstraint.isActive = true
    }

    func configureTextInput() {
        textInput.translatesAutoresizingMaskIntoConstraints = false
        textInput.delegate = self
        textInput.textColor = Asset.grayScaleBlack.color
        textInput.textAlignment = .left
        textInput.font = inputFieldFont
        textInput.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        textInput.addTarget(self, action: #selector(textFieldEditingDidBegin), for: .editingDidBegin)

        textInput.autocapitalizationType = .words
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
        52
    }

    var fieldToError: CGFloat {
        4
    }

    var titlePosition: CGFloat {
        7
    }

    var placeholderPosition: CGFloat {
        16
    }

    func titleLabelShouldChangeStyleForTop() {
        titleLabel.font = .systemFont(ofSize: 14, weight: .regular)
    }

    func titleLabelShouldChangeStyleForCenter() {
        titleLabel.textColor = Asset.grayScaleMediumGrey.color
        titleLabel.font = placeholderFont
    }

    func setupErrorLabelProperties() {
        errorLabel.textColor = Asset.alertsDanger.color
        errorLabel.numberOfLines = 0
        errorLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    }
}
