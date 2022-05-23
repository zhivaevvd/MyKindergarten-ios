//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

public enum Router {
    static func setRoot(_ vc: UIViewController) {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController = vc
    }

    static func present(root: UIViewController, vc: UIViewController) {
        root.present(vc, animated: true)
    }

    static func push(navContr: UINavigationController?, _ vc: UIViewController) {
        guard let navContr = navContr else { return }
        navContr.pushViewController(vc, animated: true)
    }

    static func dismissFrontmost(root: UIViewController, _ completion: (() -> Void)? = nil) {
        root.dismiss(animated: true, completion: completion)
    }
}
