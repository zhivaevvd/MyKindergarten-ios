//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Combine
import UIKit

public final class ProfileVC: UIViewController {
    // MARK: Lifecycle

    public init(vm: ProfileViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        configureBindings()
        configureActions()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Public

    override public func loadView() {
        view = mainView
    }

    // MARK: Private

    private let mainView = ProfileView()

    private let vm: ProfileViewModel

    private var subscriptions = Set<AnyCancellable>()

    private func configureBindings() {
        vm.user.drive { [weak self] user in
            self?.mainView.user = user
        }.store(in: &subscriptions)
    }

    private func configureActions() {
        mainView.logoutButton.setAction(for: .touchUpInside) { [weak self] in
            guard let self = self else { return }
            self.vm.showLogoutSheet(root: self)
        }

        mainView.infoDidTap = { [weak self] in
            guard let self = self else { return }
            self.vm.showInfoSheet(root: self)
        }
    }
}
