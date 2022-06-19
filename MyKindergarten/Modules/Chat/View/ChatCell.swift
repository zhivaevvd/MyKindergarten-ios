//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import AutoLayoutSugar
import UIKit

final class ChatCell: UITableViewCell, ReusableView {
    // MARK: Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureLayout()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    var model: Chat? {
        didSet {
            guard let model = model else { return }
            messageLabel.text = model.text
            if model.sender == .user {
                containerView.backgroundColor = Asset.grayScaleBlack.color
                messageLabel.apply(.body2Regular(.white))
                containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).activate()
                containerView.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor, constant: 8).activate()
            } else {
                containerView.backgroundColor = Asset.grayScaleMediumGrey.color
                messageLabel.apply(.body2Regular(Asset.grayScaleBlack.color))
                containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).activate()
                containerView.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -8).activate()
            }
        }
    }

    // MARK: Private

    private lazy var containerView = UIView().configureWithAutoLayout {
        $0.layer.cornerRadius = 8
    }

    private lazy var messageLabel = Label().configureWithAutoLayout {
        $0.numberOfLines = 0
    }

    private func configureLayout() {
        contentView.addSubview(containerView)
        containerView.top(8).bottom(8)

        containerView.addSubview(messageLabel)
        messageLabel.top(8).left(8).bottom(8).right(8)
    }
}
