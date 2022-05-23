//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import AutoLayoutSugar
import UIKit

final class ScheduleView: UIView {
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

    private(set) lazy var tableView = UITableView().configureWithAutoLayout {
        $0.register(ScheduleCell.self)
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
        $0.separatorStyle = .none
    }

    private(set) lazy var refreshControl = UIRefreshControl().prepareForAutoLayout()

    // MARK: Private

    private func configureSubviews() {
        addSubview(tableView)
        tableView.refreshControl = refreshControl
        tableView.contentInset.top = 20
    }

    private func makeConstraints() {
        tableView.pinToSuperview()
    }
}
