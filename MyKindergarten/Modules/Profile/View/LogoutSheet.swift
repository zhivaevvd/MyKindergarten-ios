//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import AutoLayoutSugar
import UIKit

public final class LogoutSheet: UIView {
    // MARK: Lifecycle

    override public init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    private(set) lazy var logoutButton = StyledButton(style: .darkGray44, title: L10n.Profile.confirmLogout).prepareForAutoLayout()

    private(set) lazy var closeButton = StyledButton(style: .lightGray44, title: L10n.Common.close).prepareForAutoLayout()

    // MARK: Private

    private lazy var titleLabel = Label(.heading2Medium()).configureWithAutoLayout {
        $0.text = L10n.Profile.warning
        $0.textAlignment = .left
    }

    private func configureSubviews() {
        addSubviews([titleLabel, logoutButton, closeButton])
    }

    private func makeConstraints() {
        titleLabel
            .top()
            .left()
            .right()

        logoutButton
            .top(to: .bottom(24), of: titleLabel)
            .left()
            .right()

        closeButton
            .top(to: .bottom(12), of: logoutButton)
            .left()
            .right()
            .bottom()
    }
}
