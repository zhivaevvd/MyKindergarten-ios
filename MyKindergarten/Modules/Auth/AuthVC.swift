//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import AutoLayoutSugar
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
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(btn)
        btn.centerX().centerY().height(44)
        let dataBase = Firestore.firestore()
        let docRef = dataBase.collection("Users").document("26jsi3K4zrLeoyFXt4Z4")
        docRef.getDocument { snap, error in
            guard let user: User = try? snap?.data(as: User.self), error == nil else {
                return
            }
            print(user.name)
        }
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
        Router.setRoot(VCFactory.buildTabBarVC())
    }
}
