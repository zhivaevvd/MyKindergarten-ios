//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Firebase
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: Internal

    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white

        let initialVC: UIViewController? = dataService.appState.isUserAuthenticated ? VCFactory.buildTabBarVC() : VCFactory.buildAuthVC()
        window?.rootViewController = initialVC
        window?.makeKeyAndVisible()
        // configureNavigationBar()
        return true
    }

    // MARK: Private

    private let dataService: DataService = CoreFactory.dataService
}
