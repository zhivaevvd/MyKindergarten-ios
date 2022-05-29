//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import AutoLayoutSugar
import UIKit

final class ScheduleItemView: UIView {
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

    var teacherDidTap: ((Teacher) -> Void)?

    var model: ScheduleItem? {
        didSet {
            guard let model = model else { return }

            aboutDescriptionLabel.text = model.description
            titleLabel.text = L10n.Schedule.itemTitle(model.title)
            groupLabel.text = L10n.Schedule.group(model.group)
            weekLabel.text = L10n.Schedule.week(model.week)
            weekTheme.text = L10n.Schedule.weekTheme(model.weekTheme)
            teacherView.person = model.teacher
            teacherView.tapAction = { [weak self] person in
                self?.teacherDidTap?(person)
            }

            tasksStackView.removeAllArrangedSubviews()
            for task in model.tasks {
                let view = TaskItemView()
                view.task = task
                tasksStackView.addArrangedSubview(view)
            }
        }
    }

    // MARK: Private

    private lazy var scrollView = UIScrollView().configureWithAutoLayout {
        $0.showsVerticalScrollIndicator = false
    }

    private lazy var titleLabel = Label(.heading3Medium()).prepareForAutoLayout()

    private lazy var groupLabel = Label(.heading3Medium()).prepareForAutoLayout()

    private lazy var weekLabel = Label(.heading3Medium()).prepareForAutoLayout()

    private lazy var weekTheme = Label(.heading3Medium()).prepareForAutoLayout()

    private lazy var aboutTitleLabel = Label(.heading1Medium()).configureWithAutoLayout {
        $0.text = L10n.Schedule.about
    }

    private lazy var aboutDescriptionLabel = Label(.body1Medium()).configureWithAutoLayout {
        $0.numberOfLines = 0
        $0.textAlignment = .left
    }

    private lazy var tasksLabel = Label(.heading1Medium()).configureWithAutoLayout {
        $0.text = L10n.Schedule.tasks
    }

    private lazy var tasksStackView = UIStackView().configureWithAutoLayout {
        $0.axis = .vertical
        $0.spacing = 8
    }

    private lazy var containerView = UIView().prepareForAutoLayout()

    private lazy var teacherView = TeacherView().prepareForAutoLayout()

    private lazy var teacherLabel = Label(.heading1Medium()).configureWithAutoLayout {
        $0.text = L10n.Schedule.teacherTitle
    }

    private func configureSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView
            .addSubviews([
                aboutTitleLabel,
                aboutDescriptionLabel,
                titleLabel,
                groupLabel,
                weekLabel,
                weekTheme,
                teacherLabel,
                teacherView,
                tasksLabel,
                tasksStackView,
            ])
    }

    private func makeConstraints() {
        scrollView.pinToSuperview()
        containerView
            .top()
            .left()
            .right()
        containerView.widthAnchor.constraint(equalTo: widthAnchor).priority(999).activate()
        aboutTitleLabel.left(16).right(16).top(16)
        aboutDescriptionLabel.left(16).right(16).top(to: .bottom(12), of: aboutTitleLabel)
        titleLabel.top(to: .bottom(24), of: aboutDescriptionLabel).left(16).right(16)
        groupLabel.left(16).right(16).top(to: .bottom(12), of: titleLabel)
        weekLabel.left(16).right(16).top(to: .bottom(12), of: groupLabel)
        weekTheme.left(16).right(16).top(to: .bottom(12), of: weekLabel)
        teacherLabel.top(to: .bottom(24), of: weekTheme).left(16).right(16)
        teacherView.top(to: .bottom(12), of: teacherLabel).left(16).right(16)
        tasksLabel.top(to: .bottom(24), of: teacherView).left(16).right(16)
        tasksStackView.top(to: .bottom(12), of: tasksLabel).left(16).right(16).bottom(20)
    }
}
