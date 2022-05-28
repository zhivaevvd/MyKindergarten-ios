//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Combine
import Foundation
import UIKit

// MARK: - ScheduleViewModel

public protocol ScheduleViewModel: AnyObject {
    var isLoading: AnyPublisher<Bool, Never> { get }
    var scheduleDataSource: AnyPublisher<[Schedule], Never> { get }
    var placeholderTrigger: AnyPublisher<PlaceholderAction, Never> { get }

    func scheduleItemDidTap(at indexPath: IndexPath, navContr: UINavigationController)
    func refresh()
    func selectDate(root: UIViewController)
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
    
    public var placeholderTrigger: AnyPublisher<PlaceholderAction, Never> {
        $_placeholderTrigger.eraseToAnyPublisher()
    }

    public func scheduleItemDidTap(at indexPath: IndexPath, navContr: UINavigationController) {
        guard selectedDate != "" else {
            Snack.weekNotChoosen()
            return
        }

        _isLoading = true

        var group = dataService.group!

        if group == "Старшая" {
            group = "senior"
        }

        service.getScheduleItem(
            group: group,
            week: selectedDate,
            id: _scheduleDataSource[indexPath.row].id,
            completion: { [weak self] result in
                switch result {
                case let .success(item):
                    guard let item = item as? ScheduleItem else { return }
                    Router.push(navContr: navContr, VCFactory.buildScheduleItemVC(item: item))
                case let .failure(error):
                    if error.localizedDescription == L10n.Auth.noInternetError {
                        Snack.noInternet()
                    } else {
                        Snack.commonError()
                    }
                }

                self?._isLoading = false
            }
        )
    }

    public func refresh() {
        _scheduleDataSource.removeAll()
        requestSchedule()
    }

    public func selectDate(root: UIViewController) {
        let view = ChooseWeekSheet().prepareForAutoLayout()
        let parameters = BottomSheetParameters(contentView: view)
        view.date.drive { [weak self] date in
            self?.selectedDate = date
        }.store(in: &subscriptions)
        view.confirmButton.setAction(for: .touchUpInside) {
            Router.dismissFrontmost(root: root)
        }
        Router.present(root: root, vc: VCFactory.buildBottomSheetVC(parameters: parameters))
    }

    // MARK: Private

    private var selectedDate = String()
    private let service: ScheduleService

    private let dataService: DataService

    private var subscriptions = Set<AnyCancellable>()

    @Published
    private var _isLoading = false

    @Published
    private var _scheduleDataSource: [Schedule] = []
    
    @Published
    private var _placeholderTrigger: PlaceholderAction = .hide

    private func requestSchedule() {
        _isLoading = true
        service.getSchedule { [weak self] result in
            switch result {
            case let .success(schedule):
                self?._scheduleDataSource = schedule as! [Schedule]
                self?._placeholderTrigger = .hide
            case let .failure(error):
                if error.localizedDescription == L10n.Auth.noInternetError {
                   // Snack.noInternet()
                    self?._placeholderTrigger = .show(.noInternetPlaceholder({ [weak self] in
                        self?.requestSchedule()
                    }))
                } else {
                   // Snack.commonError()
                    self?._placeholderTrigger = .show(.unknownErrorPlaceholder({ [weak self] in
                        self?.requestSchedule()
                    }))
                }
            }
            self?._isLoading = false
        }
    }
}
