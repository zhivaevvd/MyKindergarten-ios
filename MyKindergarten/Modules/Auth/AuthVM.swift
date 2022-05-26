//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import AutoLayoutSugar
import Combine
import FirebaseAuth
import Foundation
import UIKit

// MARK: - AuthViewModel

public protocol AuthViewModel: AnyObject {
    var isLoading: AnyPublisher<Bool, Never> { get }
    var emailFieldModel: FieldModel { get }
    var passwordFieldModel: FieldModel { get }
    var isAuthButtonActive: AnyPublisher<Bool, Never> { get }

    func showNoAccessBottomSheet(root: UIViewController)
    func auth()
}

// MARK: - AuthVM

public final class AuthVM: AuthViewModel {
    // MARK: Lifecycle

    public init(service: ProfileService, dataService: DataService) {
        self.service = service
        self.dataService = dataService
        listenEmailField()
    }

    // MARK: Public

    public private(set) var emailFieldModel: FieldModel = .init(validator: EmailValidator.common)

    public private(set) var passwordFieldModel: FieldModel = .init(validator: PasswordValidator.common)

    public var isLoading: AnyPublisher<Bool, Never> {
        $_isLoading.eraseToAnyPublisher()
    }

    public var isAuthButtonActive: AnyPublisher<Bool, Never> {
        $_isAuthButtonActive.eraseToAnyPublisher()
    }

    public func showNoAccessBottomSheet(root: UIViewController) {
        let view = NoAccessBottomSheet().prepareForAutoLayout()
        let parameters = BottomSheetParameters(contentView: view)
        Router.present(root: root, vc: VCFactory.buildBottomSheetVC(parameters: parameters))
    }

    public func auth() {
        guard passwordFieldModel.validate() else { return }
        makeAuth()
    }

    // MARK: Private

    @Published
    private var _isLoading = false

    @Published
    private var _isAuthButtonActive = false

    private let service: ProfileService

    private let dataService: DataService

    private var subscriptions = Set<AnyCancellable>()

    private func makeAuth() {
        _isLoading = true
        service.auth(with: emailFieldModel.uFieldValue, and: passwordFieldModel.uFieldValue) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(accessToken):
                self.dataService.appState.accessToken = accessToken as? String
                self.service.getUser(uid: accessToken as! String) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case let .success(user):
                        self.dataService.appState.user = user as? User
                    case let .failure(error):
                        self.handleError(error: error)
                    }
                }
                Router.setRoot(VCFactory.buildTabBarVC())
            case let .failure(error):
                self.handleError(error: error)
            }
            self._isLoading = false
        }
    }

    private func handleError(error: Error) {
        if error.localizedDescription == L10n.Auth.noUserError {
            Snack.noUserError()
        } else {
            Snack.authError(error.localizedDescription == L10n.Auth.noInternetError)
        }
    }

    private func listenEmailField() {
        emailFieldModel.value.sink { [weak self] _ in
            guard let self = self else { return }
            guard self.emailFieldModel.validate(emptyCheck: true, notifyError: false) else {
                self._isAuthButtonActive = false
                return
            }

            self._isAuthButtonActive = true
        }.store(in: &subscriptions)
    }
}
