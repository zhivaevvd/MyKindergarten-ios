//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import AutoLayoutSugar
import Combine
import UIKit

// MARK: - ScheduleVC

public final class ScheduleVC: UIViewController {
    // MARK: Lifecycle

    public init(vm: ScheduleViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Неделя", style: .plain, target: self, action: #selector(weekTap))
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

    @objc
    private func weekTap() {
        vm.selectDate(root: self)
    }

    private func configureBindings() {
        vm.scheduleDataSource.drive { [weak self] dataSource in
            self?.applyScheduleSnapshot(with: dataSource)
        }.store(in: &subscriptions)

        vm.isLoading.drive { [weak self] isLoading in
            isLoading ? self?.mainView.startLoading(with: .dark) : self?.mainView.stopLoadingProgress()
        }.store(in: &subscriptions)
        
        vm.placeholderTrigger.drive { [weak self] action in
            guard let self = self else { return }
            
            switch action {
            case let .show(parameters):
                self.mainView.showPlaceholder(with: parameters.withLayout(.custom(layoutBuilder: { view in
                    view.safeArea {
                        $0.top()
                        $0.bottom(20)
                        $0.left(16)
                        $0.right(16)
                    }
                })))
            case .hide:
                self.mainView.hidePlaceholder()
            }
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
        guard let navContr = navigationController else { return }
        vm.scheduleItemDidTap(at: indexPath, navContr: navContr)
    }
}
