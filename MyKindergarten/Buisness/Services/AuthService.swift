//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Combine
import FirebaseFirestore
import Foundation

// MARK: - AuthService

public protocol AuthService: AnyObject {
    func auth(with phone: String, and password: String)
}

// MARK: - AuthServiceImpl

public final class AuthServiceImpl: AuthService {
    // MARK: Lifecycle

    public init() {
        database = Firestore.firestore()
    }

    // MARK: Public

    public func auth(with phone: String, and _: String) {
        docRef = database.collection("Users").document(phone)
        docRef?.getDocument { snap, _ in
            guard let user = try? snap?.data(as: User.self) else { return }
            print(user.phone)
        }
    }

    // MARK: Private

    private let database: Firestore

    private var docRef: DocumentReference?
}
