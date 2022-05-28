//
// FittyWork
// Copyright © 2022 Heads and Hands. All rights reserved.
//

import UIKit

public final class PlaceholderView: UIView {
    // MARK: Lifecycle

    override public init(frame: CGRect = .zero) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true
        backgroundColor = .white

        configureLayout()
        makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("NSCoder init is not supported")
    }

    // MARK: Public

    public func show(with parameters: PlaceholderParameters) {
        self.parameters = parameters

        isHidden = false
        titleLabel.text = parameters.title
        descriptionLabel.text = parameters.description

        imageView.image = parameters.image

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: parameters.imageSize.rawValue),
            imageView.heightAnchor.constraint(equalToConstant: parameters.imageSize.rawValue),
        ])

        actionButton.setTitle(parameters.button?.title, for: .normal)

        titleLabel.isHidden = parameters.title.isEmpty
        descriptionLabel.isHidden = parameters.description == nil
        imageView.isHidden = parameters.image == nil
        actionButton.isHidden = parameters.button == nil

        containerViewCenterYAnchor?.isActive = parameters.fullScreen
        containerViewBottomAnchor?.isActive = parameters.fullScreen
        actionButtonTopConstraint?.isActive = !parameters.fullScreen
    }

    public func hide() {
        isHidden = true
    }

    // MARK: Private

    private var parameters: PlaceholderParameters?

    private var containerViewBottomAnchor: NSLayoutConstraint?

    private var containerViewCenterYAnchor: NSLayoutConstraint?

    private var actionButtonTopConstraint: NSLayoutConstraint?

    private lazy var containerView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [imageView, labelsStack])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 32
        return view
    }()

    private lazy var titleLabel: Label = {
        let label = Label(.heading2Medium())
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: Label = {
        let label = Label(.body2Regular())
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()

    private lazy var labelsStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 12
        return view
    }()

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var actionButton = StyledButton(style: .darkGray44, title: "").configureWithAutoLayout {
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(handleAction), for: .touchUpInside)
    }

    private func configureLayout() {
        addSubview(containerView)
        addSubview(actionButton)
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            containerView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
        ])

        containerViewBottomAnchor = containerView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
        containerViewCenterYAnchor = containerView.centerYAnchor.constraint(equalTo: centerYAnchor)
        actionButtonTopConstraint = actionButton.topAnchor.constraint(greaterThanOrEqualTo: containerView.bottomAnchor, constant: 16)
    }

    @objc
    private func handleAction() {
        parameters?.button?.action?()
    }
}
