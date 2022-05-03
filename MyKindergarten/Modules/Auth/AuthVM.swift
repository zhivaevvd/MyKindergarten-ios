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

    func showNoAccessBottomSheet()
    func auth()
}

// MARK: - AuthVM

public final class AuthVM: AuthViewModel {
    // MARK: Lifecycle

    public init(service: AuthService) {
        self.service = service
    }

    // MARK: Public

    public var isLoading: AnyPublisher<Bool, Never> {
        $_isLoading.eraseToAnyPublisher()
    }

    public func showNoAccessBottomSheet() {}

    public func auth() {
        service.auth(with: "test@mm.mm", and: "111111") { [weak self] result in
            switch result {
            case let .success(id):
                print(id)
            case let .failure(err):
                print(err.localizedDescription)
            }
        }
    }

    // MARK: Private

    @Published
    private var _isLoading = false

    private let service: AuthService

    private var userId: String?

    private var subscriptions = Set<AnyCancellable>()

    private func printError(completion: Subscribers.Completion<Error>) {
        guard case let .failure(reason) = completion else { return }
        print(reason.localizedDescription)
    }
}
