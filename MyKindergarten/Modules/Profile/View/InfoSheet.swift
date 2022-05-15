//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import AutoLayoutSugar
import UIKit

public final class InfoSheet: UIView {
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

    // MARK: Private

    private lazy var titleLabel = Label(.heading3Medium()).configureWithAutoLayout {
        $0.text = L10n.Profile.infoTitle
    }

    private lazy var messageLabel = Label(.body1Regular()).configureWithAutoLayout {
        $0.text = L10n.Profile.infoDescription
        $0.numberOfLines = 0
        $0.textAlignment = .left
    }

    private func configureSubviews() {
        addSubviews([titleLabel, messageLabel])
    }

    private func makeConstraints() {
        titleLabel.top().left().right()
        messageLabel.top(to: .bottom(12), of: titleLabel).left().right().bottom()
    }
}
