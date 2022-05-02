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
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: Internal

    private(set) lazy var noAccessButton = StyledButton(style: .plainGrayText, title: L10n.Auth.CantLogIn.title).prepareForAutoLayout()

    private(set) lazy var authButton = StyledButton(style: .darkGray44, title: L10n.Auth.logIn).prepareForAutoLayout()

    // MARK: Private

    private lazy var titleLabel = Label(.heading1Medium()).configureWithAutoLayout {
        $0.text = L10n.Auth.title
    }

    private func configureSubviews() {
        addSubviews([titleLabel, noAccessButton, authButton])
    }

    private func makeConstraints() {
        titleLabel.safeArea { $0.top(24) }.centerX()
        noAccessButton.top(to: .bottom(24), of: titleLabel).left(16).right(16)
        authButton.left(16).right(16).bottom(24)
    }
}
