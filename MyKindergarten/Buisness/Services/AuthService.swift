//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Firebase
import Foundation

// MARK: - AuthService

public protocol AuthService: AnyObject {
    func auth(with email: String, and password: String, completion: @escaping (Result) -> Void)
}

// MARK: - AuthServiceImpl

public final class AuthServiceImpl: AuthService {
    // MARK: Lifecycle

    public init() {
        firebaseAuth = Auth.auth()
    }

    // MARK: Public

    public func auth(with email: String, and password: String, completion: @escaping (Result) -> Void) {
        firebaseAuth.signIn(withEmail: email, password: password) { result, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }

            completion(.success(result?.user.uid ?? ""))
        }
    }

    // MARK: Private

    private let firebaseAuth: Auth
}
