//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import AutoLayoutSugar
import Kingfisher
import UIKit

public final class ProfileAvatarView: UIView, UIScrollViewDelegate {
    // MARK: Lifecycle

    override public init(frame: CGRect = .zero) {
        super.init(frame: frame)
        backgroundColor = Asset.grayScaleLightGray.color
        layer.cornerRadius = 12
        layer.masksToBounds = true
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        addSubviews([scrollView, pageControl])
        scrollView.pinToSuperview()
        scrollView.addSubview(stackView)
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        stackView.heightAnchor.constraint(equalTo: heightAnchor).activate()
        stackView.pinToSuperview()
        pageControl.centerX().bottom(8)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: Public

    public var avatarShouldChange: (() -> Void)?

    public var previewShouldOpen: (() -> Void)?
    public var noAvatarImage: UIImage = Asset.profilePlaceholder.image

    public var currentIdx: Int {
        pageControl.currentPage
    }

    public var isAvatarEmpty: Bool {
        sources?.isEmpty ?? false
    }

    public func scrollViewDidScroll(_ sv: UIScrollView) {
        pageControl.currentPage = stackView.arrangedSubviews.lastIndex(where: { $0.frame.contains(sv.contentOffset) }) ?? 0
    }

    public func configureWithImage(sources: [String?]) {
        guard self.sources != sources else {
            return
        }
        self.sources = sources
        pageControl.numberOfPages = sources.count
        pageControl.currentPage = 0
        stackView.subviews.forEach { $0.removeFromSuperview() }
        if sources.isEmpty {
            let noAvatarView = UIView().prepareForAutoLayout()
            let noAvatarImageView = UIImageView(image: noAvatarImage).prepareForAutoLayout()
            noAvatarImageView.contentMode = .scaleAspectFit
            noAvatarView.addSubview(noAvatarImageView)
            noAvatarImageView.centerX().width(140).height(140).bottom(54)
            stackView.addArrangedSubview(noAvatarView)
            noAvatarView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        } else {
            stackView.addArrangedSubviews(sources.map { source in UIImageView().configureWithAutoLayout {
                $0.loadImage(url: source)
                $0.contentMode = .scaleAspectFill
                $0.clipsToBounds = true
                $0.heightAnchor.constraint(equalToConstant: 282 * UIScreen.main.bounds.width / 375).priority(999).activate()
            } })
        }

        stackView.arrangedSubviews.forEach { $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true }
    }

    // MARK: Private

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    private var pageControl = PageControl().prepareForAutoLayout()

    private lazy var stackView = UIStackView().configureWithAutoLayout {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }

    private var prefetcher: ImagePrefetcher?

    private var sources: [String?]? {
        didSet {
            guard sources != oldValue else {
                return
            }
            prefetcher?.stop()
            prefetcher = ImagePrefetcher(urls: sources?.compactMap { URL(string: $0 ?? "") } ?? [])
            prefetcher?.start()
        }
    }

    @objc
    private func didTap(_: UITapGestureRecognizer) {
        isAvatarEmpty ? avatarShouldChange?() : previewShouldOpen?()
    }
}
