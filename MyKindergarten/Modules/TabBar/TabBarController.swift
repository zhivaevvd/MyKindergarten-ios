//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

public class TabBarController: UITabBarController {
    // MARK: Lifecycle

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTabBar()
    }

    // MARK: Private

    private var profileVC: UIViewController = UINavigationController(rootViewController: VCFactory.buildProfileVC())

    //private var chatVC: UIViewController = UINavigationController(rootViewController: VCFactory.buildChatVC())

    private var scheduleVC: UIViewController = UINavigationController(rootViewController: VCFactory.buildScheduleVC())

    private func setupTabBar() {
        modalPresentationStyle = .fullScreen
        setViewControllers([scheduleVC, profileVC], animated: false)
        scheduleVC.title = L10n.Tabbar.schedule
        scheduleVC.tabBarItem.image = UIImage(systemName: "calendar")

        profileVC.title = L10n.Tabbar.profile
        profileVC.tabBarItem.image = UIImage(systemName: "person.fill")

//        chatVC.title = "Чат"
//        chatVC.tabBarItem.image = UIImage(systemName: "message.fill")
    }
}
