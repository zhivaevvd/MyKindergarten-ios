//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Combine
import UIKit

// MARK: - ScheduleVC

public final class ScheduleVC: UIViewController {
    // MARK: Lifecycle

    public init(vm: ScheduleViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        configureBindings()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.Tabbar.schedule
        mainView.tableView.delegate = self
        mainView.refreshControl.setAction(for: .valueChanged) { [weak self] in
            self?.vm.refresh()
            self?.mainView.refreshControl.endRefreshing()
        }
        setupTableView()
    }

    // MARK: Public

    override public func loadView() {
        view = mainView
    }

    // MARK: Private

    private let mainView = ScheduleView()

    private let vm: ScheduleViewModel

    private var subscriptions = Set<AnyCancellable>()

    private var scheduleDataSource: UITableViewDiffableDataSource<SimpleDiffableSection, Schedule>?

    private func configureBindings() {
        vm.scheduleDataSource.drive { [weak self] dataSource in
            self?.applyScheduleSnapshot(with: dataSource)
        }.store(in: &subscriptions)
    }
}

extension ScheduleVC {
    private func setupTableView() {
        scheduleDataSource = UITableViewDiffableDataSource<SimpleDiffableSection, Schedule>(
            tableView: mainView.tableView,
            cellProvider: { tableView, indexPath, schedule -> UITableViewCell? in
                let cell: ScheduleCell = tableView.dequeueReusableCell(for: indexPath)
                cell.configureCell(name: schedule.name, teacher: schedule.teacher)
                return cell
            }
        )
    }

    private func applyScheduleSnapshot(with schedule: [Schedule]) {
        var snapshot = NSDiffableDataSourceSnapshot<SimpleDiffableSection, Schedule>()
        snapshot.appendSections([.main])
        snapshot.appendItems(schedule, toSection: .main)
        scheduleDataSource?.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: UITableViewDelegate

extension ScheduleVC: UITableViewDelegate {
    public func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        vm.scheduleItemDidTap(at: indexPath)
    }
}