//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

enum VCFactory {
    static func buildAuthVC() -> UIViewController? {
        let vm = AuthVM()
        let vc = AuthVC(vm: vm)
        return vc
    }

    static func buildTabBarVC() -> UIViewController? {
        let vc = TabBarController()
        return vc
    }

    static func buildProfileVC() -> UIViewController {
        let vc = ProfileVC()
        return vc
    }

    static func buildChatVC() -> UIViewController {
        let vc = ChatVC()
        return vc
    }

    static func buildScheduleVC() -> UIViewController {
        let vc = ScheduleVC()
        return vc
    }
}
