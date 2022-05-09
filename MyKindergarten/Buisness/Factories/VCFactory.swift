//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

enum VCFactory {
    static let dataService: DataService = CoreFactory.dataService

    static let authService: AuthService = CoreFactory.authService

    static func buildAuthVC() -> UIViewController {
        let vm = AuthVM(service: authService, appState: dataService.appState)
        let vc = AuthVC(vm: vm)
        return vc
    }

    static func buildTabBarVC() -> UIViewController {
        let vc = TabBarController()
        return vc
    }

    static func buildProfileVC() -> UIViewController {
        let vc = ProfileVC()
        vc.setup(with: dataService)
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
