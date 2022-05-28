//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import AutoLayoutSugar
import UIKit

final class TaskItemView: UIView {
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

    var task: Task? {
        didSet {
            guard let task = task else { return }
            taskLabel.text = task.task
            guard let url = task.url else { return }
            showRecomendationButton.setAction(for: .touchUpInside) { [weak self] in
                self?.openUrl(stringUrl: url)
            }
        }
    }

    // MARK: Private

    private lazy var containerView = UIView().configureWithAutoLayout {
        $0.backgroundColor = Asset.grayScaleLightGray.color
        $0.layer.cornerRadius = 8
    }

    private lazy var taskLabel = Label(.body2Regular()).configureWithAutoLayout {
        $0.numberOfLines = 0
        $0.textAlignment = .left
    }

    private lazy var showRecomendationButton = StyledButton(style: .plainBlueText, title: L10n.Schedule.showRecomendations)
        .prepareForAutoLayout()

    private func configureSubviews() {
        addSubview(containerView)
        containerView.addSubviews([taskLabel, showRecomendationButton])
    }

    private func makeConstraints() {
        containerView.pinToSuperview()

        taskLabel
            .top(14)
            .left(16)
            .right(16)

        showRecomendationButton
            .top(to: .bottom(12), of: taskLabel)
            .left(16)
            .right(16)
            .bottom(14)
    }

    private func openUrl(stringUrl: String) {
        guard let url = URL(string: stringUrl) else { return }
        UIApplication.shared.open(url)
    }
}
