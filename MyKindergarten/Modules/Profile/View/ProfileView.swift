//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import AutoLayoutSugar
import UIKit

final class ProfileView: UIView {
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

    private(set) lazy var scrollView = UIScrollView().configureWithAutoLayout {
        $0.contentInsetAdjustmentBehavior = .never
        $0.showsVerticalScrollIndicator = false
    }

    var infoDidTap: (() -> Void)?

    private(set) lazy var logoutButton = StyledButton(style: .red44, title: L10n.Profile.logout).prepareForAutoLayout()

    var user: User? {
        didSet {
            guard let user = user else { return }

            nameView.setupView(user.name, user.phone)
            nameView.infoButton.setAction(for: .touchUpInside) { [weak self] in
                self?.infoDidTap?()
            }

            addressView.addressLabel.text = user.kindergartenAddress
            groupView.groups = user.groups
            loginDetailsView.setupView(user.email, user.password)
        }
    }

    var avatarViewHeight: CGFloat {
        282 * UIScreen.main.bounds.width / 375
    }

    // MARK: Private

    private lazy var avatarView = UIImageView().configureWithAutoLayout {
        $0.image = Asset.profilePlaceholder.image
        $0.backgroundColor = Asset.grayScaleLightGray.color
        $0.layer.cornerRadius = 8
    }

    private lazy var containerView = UIView().prepareForAutoLayout()

    private lazy var nameView = NameView().prepareForAutoLayout()

    private lazy var addressView = AddressView().prepareForAutoLayout()

    private lazy var informationLabel = Label(.heading2Medium()).configureWithAutoLayout {
        $0.text = L10n.Profile.information
        $0.textAlignment = .left
    }

    private lazy var groupView = GroupView().prepareForAutoLayout()

    private lazy var loginDetailsView = LoginDetailsView().prepareForAutoLayout()

    private func configureSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews([avatarView, nameView, addressView, informationLabel, groupView, loginDetailsView, logoutButton])
    }

    private func makeConstraints() {
        scrollView.pin(excluding: .bottom)
        scrollView.safeArea { $0.bottom(0) }
        containerView
            .top()
            .left()
            .right()
            .bottom(20)
        containerView.widthAnchor.constraint(equalTo: widthAnchor).priority(999).activate()

        avatarView
            .left()
            .right()
            .bottom(to: .top(24), of: nameView)
        avatarView.topAnchor <~ topAnchor + 0

        nameView
            .left()
            .right()
            .top(avatarViewHeight)

        addressView
            .left()
            .right()
            .top(to: .bottom(12), of: nameView)

        informationLabel
            .top(to: .bottom(24), of: addressView)
            .left(16)
            .right(16)

        groupView
            .left()
            .right()
            .top(to: .bottom(12), of: informationLabel)

        loginDetailsView
            .top(to: .bottom(12), of: groupView)
            .left(16)
            .right(16)

        logoutButton
            .top(to: .bottom(24), of: loginDetailsView)
            .left(16)
            .right(16)
            .bottom()
    }
}
