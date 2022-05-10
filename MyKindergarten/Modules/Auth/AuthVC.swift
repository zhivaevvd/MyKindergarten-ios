//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import AutoLayoutSugar
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import KeychainAccess
import UIKit

public final class AuthVC: UIViewController {
    // MARK: Lifecycle

    public init(vm: AuthViewModel) {
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

    private var subscriptions = Set<AnyCancellable>()

    private let vm: AuthViewModel

    private let dataService: DataService = CoreFactory.dataService

    private let mainView = AuthView()

    private func configureBindings() {
        mainView.emailField.error = vm.emailFieldModel.error
        mainView.passwordField.error = vm.passwordFieldModel.error

        mainView.emailField.text.sink { [weak self] value in
            self?.vm.emailFieldModel.setValue(value)
        }.store(in: &subscriptions)

        mainView.passwordField.text.sink { [weak self] value in
            self?.vm.passwordFieldModel.setValue(value)
        }.store(in: &subscriptions)

        vm.isAuthButtonActive.drive { [weak self] isActive in
            self?.mainView.authButton.isEnabled = isActive
        }.store(in: &subscriptions)

        vm.isLoading.drive { [weak self] isLoading in
            self?.mainView.authButton.isLoading = isLoading
        }.store(in: &subscriptions)
    }

    private func configureActions() {
        mainView.authButton.setAction(for: .touchUpInside) { [weak self] in
            self?.vm.auth()
        }

        mainView.noAccessButton.setAction(for: .touchUpInside) { [weak self] in
            guard let self = self else { return }
            self.vm.showNoAccessBottomSheet(root: self)
        }
    }
}
