//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import AutoLayoutSugar
import KeychainAccess
import UIKit

public final class AuthVC: UIViewController {
    // MARK: Lifecycle

    public init(vm: AuthViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(btn)
        btn.centerX().centerY().height(44)
    }

    // MARK: Private

    private let vm: AuthViewModel

    private let dataService: DataService = CoreFactory.dataService

    private lazy var btn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setTitle(L10n.open, for: .normal)
        btn.setAction(for: .touchUpInside) { [weak self] in
            self?.btnTapped()
        }
        return btn
    }()

    private func btnTapped() {
        dataService.appState.accessToken = "saawfw"
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController = VCFactory.buildTabBarVC()
    }
}
