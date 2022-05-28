//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Combine
import Foundation
import UIKit

// MARK: - ScheduleItemViewModel

public protocol ScheduleItemViewModel: AnyObject {
    var scheduleItem: ScheduleItem { get }

    func showTeacherCard(_ teacher: Teacher, navContr: UINavigationController)
}

// MARK: - ScheduleItemVM

public final class ScheduleItemVM: ScheduleItemViewModel {
    // MARK: Lifecycle

    public init(service: ScheduleService, item: ScheduleItem) {
        self.service = service
        scheduleItem = item
    }

    // MARK: Public

    public let scheduleItem: ScheduleItem

    public func showTeacherCard(_ teacher: Teacher, navContr: UINavigationController) {
        Router.push(navContr: navContr, VCFactory.buildTeacherCardVC(teacher: teacher))
    }

    // MARK: Private

    private let service: ScheduleService

    private var subscriptions = Set<AnyCancellable>()
}
