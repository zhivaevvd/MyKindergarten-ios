//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

enum VCFactory {
    static let dataService: DataService = CoreFactory.dataService

    static let profileService: ProfileService = CoreFactory.authService

    static let scheduleService: ScheduleService = CoreFactory.scheduleService

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
        let vm = ScheduleVM(service: scheduleService, dataService: dataService)
        let vc = ScheduleVC(vm: vm)
        return vc
    }

    static func buildScheduleItemVC(item: ScheduleItem) -> UIViewController {
        let vm = ScheduleItemVM(service: scheduleService, item: item)
        return ScheduleItemVC(vm: vm)
    }

    static func buildBottomSheetVC(parameters: BottomSheetParametersProtocol) -> UIViewController {
        let vc = BottomSheetController(arguments: parameters)
        vc.transitioningDelegate = vc
        return vc
    }

    static func buildTeacherCardVC(teacher: Teacher) -> UIViewController {
        TeacherCardVC(teacher: teacher)
    }
}
