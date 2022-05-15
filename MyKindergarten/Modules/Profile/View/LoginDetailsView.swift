//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import AutoLayoutSugar
import UIKit

final class LoginDetailsView: UIView {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    func setupView(_ login: String, _ password: String) {
        loginLabel.text = login
        passwordLabel.text = password
    }

    // MARK: Private

    private lazy var loginLabel = Label(.heading1Medium()).configureWithAutoLayout {
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }

    private lazy var loginDescription = Label(.body2Regular(Asset.grayScaleMediumGrey.color)).configureWithAutoLayout {
        $0.text = L10n.Profile.login.lowercased()
    }

    private lazy var passwordLabel = Label(.heading1Medium()).configureWithAutoLayout {
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }

    private lazy var passwordDescription = Label(.body2Regular(Asset.grayScaleMediumGrey.color)).configureWithAutoLayout {
        $0.text = L10n.Profile.password.lowercased()
    }

    private lazy var loginView = UIView().configureWithAutoLayout {
        $0.backgroundColor = Asset.grayScaleLightGray.color
        $0.layer.cornerRadius = 8
        $0.addSubviews([loginLabel, loginDescription])
    }

    private lazy var passwordView = UIView().configureWithAutoLayout {
        $0.backgroundColor = Asset.grayScaleLightGray.color
        $0.layer.cornerRadius = 8
        $0.addSubviews([passwordLabel, passwordDescription])
    }

    private lazy var contentStackView = UIStackView().configureWithAutoLayout {
        $0.axis = .vertical
        $0.spacing = 12
        $0.distribution = .fillEqually
    }

    private func configureSubviews() {
        addSubview(contentStackView)
        contentStackView.addArrangedSubviews([loginView, passwordView])
    }

    private func makeConstraints() {
        contentStackView.pinToSuperview()

        loginLabel.left(16).right(16).top(12)
        loginDescription.centerX().top(to: .bottom(2), of: loginLabel).bottom(12)

        passwordLabel.left(16).right(16).top(12)
        passwordDescription.centerX().top(to: .bottom(2), of: passwordLabel).bottom(12)
    }
}
