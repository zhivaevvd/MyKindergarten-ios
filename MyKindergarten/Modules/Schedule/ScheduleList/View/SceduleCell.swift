//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import AutoLayoutSugar
import UIKit

final class ScheduleCell: UITableViewCell, ReusableView {
    // MARK: Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureSubviews()
        makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    func configureCell(name: String, teacher: String) {
        nameLabel.text = name
        teacherLabel.text = L10n.Schedule.teacher(teacher)
    }

    // MARK: Private

    private lazy var nameLabel = Label(.heading3Medium()).prepareForAutoLayout()

    private lazy var teacherLabel = Label(.body2Medium(Asset.grayScaleMediumGrey.color)).prepareForAutoLayout()

    private lazy var separator = UIView.separator()

    private func configureSubviews() {
        addSubviews([nameLabel, teacherLabel, separator])
    }

    private func makeConstraints() {
        nameLabel
            .left(16)
            .top(9)
            .right(16)

        teacherLabel
            .top(to: .bottom(2), of: nameLabel)
            .left(16)
            .right(16)

        separator
            .top(to: .bottom(16), of: teacherLabel)
            .left(16)
            .right(16)
            .bottom(9)
    }
}
