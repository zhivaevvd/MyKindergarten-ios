//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import AutoLayoutSugar
import UIKit

final class NameView: UIView {
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

    private(set) lazy var infoButton = UIButton(type: .custom).configureWithAutoLayout {
        $0.setImage(Asset.iconInfo.image, for: .normal)
    }

    func setupView(_ name: String, _ phone: String) {
        nameLabel.text = name
        phoneLabel.text = phone
    }

    // MARK: Private

    private lazy var nameLabel = Label(.heading1Medium()).configureWithAutoLayout {
        $0.numberOfLines = 0
    }

    private lazy var phoneLabel = Label(.body1Regular(Asset.grayScaleMediumGrey.color)).prepareForAutoLayout()

    private lazy var separator = UIView.separator()

    private func configureSubviews() {
        addSubviews([nameLabel, phoneLabel, infoButton, separator])
    }

    private func makeConstraints() {
        nameLabel
            .top()
            .left(16)
        nameLabel.rightAnchor <~ infoButton.leftAnchor - 8

        phoneLabel
            .left(16)
            .right(16)
            .top(to: .bottom(6), of: nameLabel)

        infoButton
            .centerY(to: nameLabel)
        infoButton.rightAnchor <~ rightAnchor - 32

        separator
            .top(to: .bottom(12), of: phoneLabel)
            .left(16)
            .right(16)
            .bottom()
    }
}
