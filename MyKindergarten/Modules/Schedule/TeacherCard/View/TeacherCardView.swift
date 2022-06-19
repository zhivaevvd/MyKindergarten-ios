//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import AutoLayoutSugar
import UIKit

final class TeacherCardView: UIView {
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

    private(set) lazy var scrollView = UIScrollView().configureWithAutoLayout {
        $0.contentInsetAdjustmentBehavior = .never
        $0.showsVerticalScrollIndicator = false
    }

    private(set) lazy var chatButton = StyledButton(style: .lightGray44, title: "Написать").prepareForAutoLayout()

    var model: Teacher? {
        didSet {
            guard let model = model else { return }
            avatarView.configureWithImage(sources: model.photos.map(\.url))
            nameLabel.text = model.name
            positionLabel.text = L10n.Schedule.position(model.position)
            experienceLabel.text = L10n.Schedule.experience(model.experience)
            attestationLabel.text = L10n.Schedule.attestation(model.attestation)

            educationDescriptionLabel.text = model.education
            advancedTrainingDescriptionLabel.text = model.advancedTraining

            guard let achievements = model.achievments else { return }
            achievementsStackView.removeAllArrangedSubviews()
            for achievement in achievements {
                let view = AchievementsItemView()
                view.achievement = achievement
                achievementsStackView.addArrangedSubview(view)
            }
        }
    }

    var avatarViewHeight: CGFloat {
        282 * UIScreen.main.bounds.width / 375
    }

    // MARK: Private

    private lazy var avatarView = ProfileAvatarView().prepareForAutoLayout()

    private lazy var nameLabel = Label(.heading1Medium()).configureWithAutoLayout {
        $0.numberOfLines = 0
        $0.textAlignment = .left
    }

    private lazy var positionLabel = Label(.body1Regular()).configureWithAutoLayout {
        $0.numberOfLines = 0
        $0.textAlignment = .left
    }

    private lazy var experienceLabel = Label(.body1Regular()).configureWithAutoLayout {
        $0.numberOfLines = 0
        $0.textAlignment = .left
    }

    private lazy var attestationLabel = Label(.body1Regular()).configureWithAutoLayout {
        $0.numberOfLines = 0
        $0.textAlignment = .left
    }

    private lazy var educationTitleLabel = Label(.heading3Medium()).configureWithAutoLayout {
        $0.text = L10n.Schedule.education
    }

    private lazy var educationDescriptionLabel = Label(.body1Regular()).configureWithAutoLayout {
        $0.numberOfLines = 0
        $0.textAlignment = .left
    }

    private lazy var advancedTrainingTitleLabel = Label(.heading3Medium()).configureWithAutoLayout {
        $0.text = L10n.Schedule.advancedTraining
    }

    private lazy var advancedTrainingDescriptionLabel = Label(.body1Regular()).configureWithAutoLayout {
        $0.numberOfLines = 0
        $0.textAlignment = .left
    }

    private lazy var achievmentsLabel = Label(.heading3Medium()).configureWithAutoLayout {
        $0.text = L10n.Schedule.achievments
    }

    private lazy var contentStackView = UIStackView().configureWithAutoLayout {
        $0.axis = .vertical
        $0.spacing = 24
    }

    private lazy var achievementsStackView = UIStackView().configureWithAutoLayout {
        $0.axis = .vertical
        $0.spacing = 12
    }

    private lazy var containerView = UIView().prepareForAutoLayout()

    private lazy var nameView = UIView().configureWithAutoLayout {
        $0.addSubviews([nameLabel, chatButton])
        nameLabel.top().left().bottom()
        nameLabel.compressionResistance(.defaultLow, .horizontal)
        chatButton.left(to: .right(12), of: nameLabel).centerY().right()
    }

    private func configureSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews([avatarView, contentStackView])
        contentStackView.addArrangedSubviews([
            nameView,
            UIView.separator(),
            positionLabel,
            experienceLabel,
            attestationLabel,
            educationTitleLabel,
            educationDescriptionLabel,
            advancedTrainingTitleLabel,
            advancedTrainingDescriptionLabel,
            achievmentsLabel,
            achievementsStackView,
        ])
    }

    private func makeConstraints() {
        scrollView.pin(excluding: .bottom)
        scrollView.safeArea { $0.bottom(0) }

        containerView.pin(excluding: .bottom)
        containerView.bottom(20)
        containerView.widthAnchor.constraint(equalTo: widthAnchor).priority(999).activate()

        avatarView
            .left()
            .right()
            .bottom(to: .top(24), of: contentStackView)
        avatarView.topAnchor <~ topAnchor + 0

        contentStackView
            .top(avatarViewHeight)
            .left(16)
            .right(16)
            .bottom()

        contentStackView.setCustomSpacing(12, after: positionLabel)
        contentStackView.setCustomSpacing(12, after: experienceLabel)
        contentStackView.setCustomSpacing(12, after: educationTitleLabel)
        contentStackView.setCustomSpacing(12, after: advancedTrainingTitleLabel)
    }
}
