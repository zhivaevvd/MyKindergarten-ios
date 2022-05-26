//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Combine
import Foundation

// MARK: - ScheduleItemViewModel

public protocol ScheduleItemViewModel: AnyObject {}

// MARK: - ScheduleItemVM

public final class ScheduleItemVM: ScheduleItemViewModel {
    // MARK: Lifecycle

    public init(service: ScheduleService, item: ScheduleItem) {
        self.service = service
        scheduleItem = item
    }

    // MARK: Private

    private let service: ScheduleService

    private let scheduleItem: ScheduleItem

    private var subscriptions = Set<AnyCancellable>()
}
