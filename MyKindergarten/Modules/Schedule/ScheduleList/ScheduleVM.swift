//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Combine
import Foundation

// MARK: - ScheduleViewModel

public protocol ScheduleViewModel: AnyObject {
    var isLoading: AnyPublisher<Bool, Never> { get }
    var scheduleDataSource: AnyPublisher<[Schedule], Never> { get }

    func scheduleItemDidTap(at indexPath: IndexPath)
    func refresh()
    func showGroupChoosing()
}

// MARK: - ScheduleVM

public final class ScheduleVM: ScheduleViewModel {
    // MARK: Lifecycle

    public init(service: ScheduleService, dataService: DataService) {
        self.service = service
        self.dataService = dataService
        requestSchedule()
    }

    // MARK: Public

    public var isLoading: AnyPublisher<Bool, Never> {
        $_isLoading.eraseToAnyPublisher()
    }

    public var scheduleDataSource: AnyPublisher<[Schedule], Never> {
        $_scheduleDataSource.eraseToAnyPublisher()
    }

    public func scheduleItemDidTap(at indexPath: IndexPath) {
        print(_scheduleDataSource[indexPath.row].id)
    }

    public func refresh() {
        _scheduleDataSource.removeAll()
        requestSchedule()
    }

    public func showGroupChoosing() {
        // TODO: group choosing
    }

    // MARK: Private

    private let service: ScheduleService

    private let dataService: DataService

    private var subscriptions = Set<AnyCancellable>()

    @Published
    private var _isLoading = false

    @Published
    private var _scheduleDataSource: [Schedule] = []

    private func requestSchedule() {
        _isLoading = true
        service.getSchedule { [weak self] result in
            switch result {
            case let .success(schedule):
                self?._scheduleDataSource = schedule as! [Schedule]
            case let .failure(error):
                if error.localizedDescription == L10n.Auth.noInternetError {
                    Snack.noInternet()
                } else {
                    Snack.commonError()
                }
            }
            self?._isLoading = false
        }
    }
}
