//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Combine
import UIKit

// MARK: - ChatVC

public final class ChatVC: UIViewController {
    // MARK: Lifecycle

    public init(vm: ChatViewModel) {
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
        setupTableView()
        title = "Чат"
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    // MARK: Public

    override public func loadView() {
        view = mainView
    }

    // MARK: Private

    private let vm: ChatViewModel

    private let mainView = ChatView()

    private var dataSource: UITableViewDiffableDataSource<SimpleDiffableSection, Chat>?

    private var subscriptions = Set<AnyCancellable>()

    private func configureBindings() {
        vm.dataSource.drive { [weak self] models in
            self?.applySnapshot(with: models)
        }.store(in: &subscriptions)
    }
}

extension ChatVC {
    private func setupTableView() {
        dataSource = UITableViewDiffableDataSource<SimpleDiffableSection, Chat>(
            tableView: mainView.tableView,
            cellProvider: { tableView, indexPath, chat -> UITableViewCell? in
                let cell: ChatCell = tableView.dequeueReusableCell(for: indexPath)
                cell.model = chat
                return cell
            }
        )
    }

    private func applySnapshot(with models: [Chat]) {
        var snap = NSDiffableDataSourceSnapshot<SimpleDiffableSection, Chat>()
        snap.appendSections([.main])
        snap.appendItems(models, toSection: .main)
        dataSource?.apply(snap, animatingDifferences: false)
    }
}
