//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

public final class PageControl: UIPageControl {
    // MARK: Lifecycle

    public init() {
        super.init(frame: .zero)
        hidesForSinglePage = true
        pageIndicatorTintColor = .clear
        currentPageIndicatorTintColor = .clear
        addSubview(dotsStackView)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: dotHeight),
            dotsStackView.topAnchor.constraint(equalTo: topAnchor),
            dotsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            dotsStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public

    override public var numberOfPages: Int {
        didSet {
            dotsStackView.subviews.forEach { $0.removeFromSuperview() }
            for index in 0 ..< numberOfPages {
                let dotView = UIView()
                dotView.accessibilityIdentifier = index.description
                dotView.translatesAutoresizingMaskIntoConstraints = false
                dotView.backgroundColor = index == 0 ? Asset.grayScaleBlack.color : Asset.grayScaleMediumGrey.color
                dotView.layer.cornerRadius = dotHeight / 2
                dotView.layer.masksToBounds = true
                dotView.widthAnchor.constraint(equalToConstant: dotHeight).isActive = true
                dotView.heightAnchor.constraint(equalToConstant: dotHeight).isActive = true
                dotsStackView.addArrangedSubview(dotView)
            }
        }
    }

    override public var currentPage: Int {
        didSet {
            updateDots()
        }
    }

    // MARK: Private

    private let dotHeight: CGFloat = 6
    private let spacing: CGFloat = 12

    private lazy var dotsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = spacing
        return stackView
    }()

    private func updateDots() {
        UIView.animate(withDuration: 0.2) {
            self.dotsStackView.arrangedSubviews.forEach {
                $0.backgroundColor = $0.accessibilityIdentifier == self.currentPage.description ? Asset.grayScaleBlack
                    .color : Asset.grayScaleMediumGrey.color
            }
        }
    }
}
