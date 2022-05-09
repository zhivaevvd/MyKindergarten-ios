//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Combine
import FirebaseAuth
import Foundation

// MARK: - AuthViewModel

public protocol AuthViewModel: AnyObject {
    var isLoading: AnyPublisher<Bool, Never> { get }
    var emailFieldModel: FieldModel { get }
    var passwordFieldModel: FieldModel { get }
    var isAuthButtonActive: AnyPublisher<Bool, Never> { get }

    func showNoAccessBottomSheet()
    func auth()
}

// MARK: - AuthVM

public final class AuthVM: AuthViewModel {
    // MARK: Lifecycle

    public init(service: AuthService, appState: AppState) {
        self.service = service
        self.appState = appState
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

    public func showNoAccessBottomSheet() {
        print("No access")
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

    private let service: AuthService

    private var appState: AppState

    private var subscriptions = Set<AnyCancellable>()

    private func makeAuth() {
        _isLoading = true
        service.auth(with: emailFieldModel.uFieldValue, and: passwordFieldModel.uFieldValue) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(accessToken):
                self._isLoading = false
                self.appState.accessToken = accessToken
                Router.setRoot(VCFactory.buildTabBarVC())
            case let .failure(err):
                // TODO: Add snack
                print(err.localizedDescription)
            }
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
