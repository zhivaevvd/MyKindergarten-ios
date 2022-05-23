//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import AutoLayoutSugar
import UIKit

final class AddressView: UIView {
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

    private(set) lazy var addressLabel = Label(.body1Regular()).configureWithAutoLayout {
        $0.numberOfLines = 0
        $0.textAlignment = .left
    }

    // MARK: Private

    private lazy var titleLabel = Label(.heading2Medium()).configureWithAutoLayout {
        $0.text = L10n.Profile.address
    }

    private func configureSubviews() {
        addSubviews([titleLabel, addressLabel])
    }

    private func makeConstraints() {
        titleLabel
            .top()
            .left(16)
            .right(16)

        addressLabel
            .top(to: .bottom(12), of: titleLabel)
            .left(16)
            .right(16)
            .bottom()
    }
}
