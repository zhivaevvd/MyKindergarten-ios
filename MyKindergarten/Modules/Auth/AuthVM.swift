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
        PhoneAuthProvider.provider().verifyPhoneNumber("+79979962921", uiDelegate: nil) { _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            // print(id)
        }
    }

    // MARK: Private

    @Published
    private var _isLoading = false

    private let service: AuthService
}
