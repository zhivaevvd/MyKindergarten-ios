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

    private let vm: AuthViewModel

    private let dataService: DataService = CoreFactory.dataService

    private let mainView = AuthView()

    private func configureBindings() {}

    private func configureActions() {
        mainView.authButton.setAction(for: .touchUpInside) { [weak self] in
            self?.vm.auth()
        }
    }
}
