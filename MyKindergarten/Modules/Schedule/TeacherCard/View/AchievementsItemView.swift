//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import AutoLayoutSugar
import UIKit

final class AchievementsItemView: UIView {
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

    var achievement: Achievment? {
        didSet {
            guard let achievement = achievement else { return }
            titleLabel.text = achievement.description
            yearLabel.text = L10n.Common.year(achievement.year)
        }
    }

    // MARK: Private

    private lazy var containerView = UIView().configureWithAutoLayout {
        $0.backgroundColor = Asset.grayScaleLightGray.color
        $0.layer.cornerRadius = 8
    }

    private lazy var titleLabel = Label(.body1Regular()).configureWithAutoLayout {
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }

    private lazy var yearLabel = Label(.caption2Medium(Asset.grayScaleMediumGrey.color)).prepareForAutoLayout()

    private func configureSubviews() {
        addSubview(containerView)
        containerView.addSubviews([titleLabel, yearLabel])
    }

    private func makeConstraints() {
        containerView.pinToSuperview()

        titleLabel
            .top(14)
            .left(16)
            .right(16)

        yearLabel
            .top(to: .bottom(12), of: titleLabel)
            .centerX()
            .bottom(14)
    }
}
