//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

public final class ProfileVC: UIViewController {
    // MARK: Lifecycle

    override public func viewDidLoad() {
        super.viewDidLoad()
        title = "Профиль"
        view.addSubview(logout)
        logout.centerY().centerX().height(44)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: Internal

    func setup(with dataService: DataService) {
        self.dataService = dataService
    }

    // MARK: Private

    private lazy var logout: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("logout", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setAction(for: .touchUpInside) { [weak self] in
            self?.logoutPressed()
        }
        btn.tintColor = .lightGray
        return btn
    }()

    private var dataService: DataService?

    private func logoutPressed() {
        dataService?.appState.accessToken = nil
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController = VCFactory.buildAuthVC()
    }
}
