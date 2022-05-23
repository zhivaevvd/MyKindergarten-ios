//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

enum VCFactory {
    static let dataService: DataService = CoreFactory.dataService

    static let profileService: ProfileService = CoreFactory.authService

    static func buildAuthVC() -> UIViewController {
        let vm = AuthVM(service: profileService, dataService: dataService)
        let vc = AuthVC(vm: vm)
        return vc
    }

    static func buildTabBarVC() -> UIViewController {
        let vc = TabBarController()
        return vc
    }

    static func buildProfileVC() -> UIViewController {
        let vm = ProfileVM(service: profileService, dataService: dataService)
        let vc = ProfileVC(vm: vm)
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

    static func buildBottomSheetVC(parameters: BottomSheetParametersProtocol) -> UIViewController {
        let vc = BottomSheetController(arguments: parameters)
        vc.transitioningDelegate = vc
        return vc
    }
}
