//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import AutoLayoutSugar
import UIKit

final class GroupView: UIView {
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

    var groups: [String]? {
        didSet {
            guard let groups = groups else { return }
            groupLabel.text = groups.joined(separator: ", ")
        }
    }

    // MARK: Private

    private lazy var groupLabel = Label(.heading1Medium()).configureWithAutoLayout {
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }

    private lazy var groupDescription = Label(.body2Regular(Asset.grayScaleMediumGrey.color)).configureWithAutoLayout {
        $0.text = L10n.Profile.group.lowercased()
    }

    private lazy var containerView = UIView().configureWithAutoLayout {
        $0.backgroundColor = Asset.grayScaleLightGray.color
        $0.layer.cornerRadius = 8
    }

    private func configureSubviews() {
        addSubview(containerView)
        containerView.addSubviews([groupLabel, groupDescription])
    }

    private func makeConstraints() {
        containerView
            .top()
            .left(16)
            .right(16)
            .bottom()

        groupLabel.left(16).right(16).top(12)
        groupDescription.centerX().top(to: .bottom(2), of: groupLabel).bottom(12)
    }
}
