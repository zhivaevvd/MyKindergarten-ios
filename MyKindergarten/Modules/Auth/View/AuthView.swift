//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import AutoLayoutSugar
import UIKit

final class AuthView: UIView {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        makeConstraints()

        let endTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(endTap))
        addGestureRecognizer(endTapRecognizer)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: Internal

    private(set) lazy var noAccessButton = StyledButton(style: .plainGrayText, title: L10n.Auth.CantLogIn.title).prepareForAutoLayout()

    private(set) lazy var authButton = StyledButton(style: .darkGray44, title: L10n.Auth.logIn).prepareForAutoLayout()

    private(set) lazy var emailField = EmailField(
        colorStyle: InputFieldColorStyles.default,
        leftMargin: 16,
        rightMargin: 16,
        placeholder: ""
    ).configureWithAutoLayout {
        $0.titleLabel.text = L10n.Auth.email
    }

    private(set) lazy var passwordField = InputField(
        colorStyle: InputFieldColorStyles.default,
        leftMargin: 16,
        rightMargin: 16,
        placeholder: ""
    ).configureWithAutoLayout {
        $0.titleLabel.text = L10n.Auth.password
        $0.textInput.isSecureTextEntry = true
    }

    // MARK: Private

    private lazy var titleLabel = Label(.heading1Medium()).configureWithAutoLayout {
        $0.text = L10n.Auth.title
    }

    private lazy var descriptionLabel = Label(.body1Regular()).configureWithAutoLayout {
        $0.text = L10n.Auth.description
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }

    private func configureSubviews() {
        addSubviews([titleLabel, descriptionLabel, emailField, passwordField, noAccessButton, authButton])
    }

    private func makeConstraints() {
        titleLabel
            .safeArea { $0.top(48) }
            .centerX()

        descriptionLabel
            .top(to: .bottom(24), of: titleLabel)
            .left(32)
            .right(32)

        emailField
            .top(to: .bottom(64), of: descriptionLabel)
            .left(32)
            .right(32)

        passwordField
            .top(to: .bottom(24), of: emailField)
            .left(32)
            .right(32)

        noAccessButton
            .top(to: .bottom(24), of: passwordField)
            .left(32)
            .right(32)

        authButton
            .top(to: .bottom(32), of: noAccessButton)
            .left(32)
            .right(32)
        authButton.bottomAnchor <~ bottomAnchor + 0
    }

    @objc
    private func endTap() {
        endEditing(true)
    }
}
