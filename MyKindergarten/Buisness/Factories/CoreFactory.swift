//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation

enum CoreFactory {
    static let dataService: DataService = DataServiceImpl()
    static let authService: ProfileService = ProfileServiceImpl()
    static let scheduleService: ScheduleService = SheduleServiceImpl()
}
