//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import AutoLayoutSugar
import Combine
import Foundation
import UIKit

// MARK: - ProfileViewModel

public protocol ProfileViewModel: AnyObject {
    var isLoading: AnyPublisher<Bool, Never> { get }
    var user: AnyPublisher<User?, Never> { get }

    func showLogoutSheet(root: UIViewController)
    func showInfoSheet(root: UIViewController)
}

// MARK: - ProfileVM

public final class ProfileVM: ProfileViewModel {
    // MARK: Lifecycle

    public init(service: ProfileService, dataService: DataService) {
        self.service = service
        self.dataService = dataService
        getUser(id: dataService.appState.accessToken ?? "")
    }

    // MARK: Public

    public var user: AnyPublisher<User?, Never> {
        $_user.eraseToAnyPublisher()
    }

    public var isLoading: AnyPublisher<Bool, Never> {
        $_isLoading.eraseToAnyPublisher()
    }

    public func showLogoutSheet(root: UIViewController) {
        let view = LogoutSheet().prepareForAutoLayout()
        view.logoutButton.setAction(for: .touchUpInside) { [weak self] in
            self?.logout()
        }
        view.closeButton.setAction(for: .touchUpInside) {
            Router.dismissFrontmost(root: root)
        }
        let parameters = BottomSheetParameters(contentView: view)
        Router.present(root: root, vc: VCFactory.buildBottomSheetVC(parameters: parameters))
    }

    public func showInfoSheet(root: UIViewController) {
        let view = InfoSheet().prepareForAutoLayout()
        let parameters = BottomSheetParameters(contentView: view)
        Router.present(root: root, vc: VCFactory.buildBottomSheetVC(parameters: parameters))
    }

    // MARK: Private

    private let service: ProfileService

    private let dataService: DataService

    @Published
    private var _user: User?

    @Published
    private var _isLoading = false

    private func logout() {
        service.logout()
        dataService.appState.accessToken = nil
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController = VCFactory.buildAuthVC()
    }

    private func getUser(id: String) {
        _isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.service.getUser(uid: id) { [weak self] result in
                switch result {
                case let .success(user):
                    self?._user = user as? User
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
//        service.getUser(uid: id) { [weak self] result in
//            switch result {
//            case let .success(user):
//                self?._user = user as? User
//            case let .failure(error):
//                if error.localizedDescription == L10n.Auth.noInternetError {
//                    Snack.noInternet()
//                } else {
//                    Snack.commonError()
//                }
//            }
//            self?._isLoading = false
//        }
    }
}
