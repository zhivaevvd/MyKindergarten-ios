//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Firebase
import Foundation
import TTGSnackbar

// MARK: - ProfileService

public protocol ProfileService: AnyObject {
    func getUser(uid: String, completion: @escaping (Result) -> Void)
    func auth(with email: String, and password: String, completion: @escaping (Result) -> Void)
    func logout()
}

// MARK: - ProfileServiceImpl

public final class ProfileServiceImpl: ProfileService {
    // MARK: Lifecycle

    public init() {
        firebaseAuth = Auth.auth()
        db = Firestore.firestore()
    }

    // MARK: Public

    public func getUser(uid: String, completion: @escaping (Result) -> Void) {
        let docRef = db.collection("Users").document(uid)

        docRef.getDocument { result, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }

            guard let user = try? result?.data(as: User.self) else { return }

            completion(.success(user))
        }
    }

    public func auth(with email: String, and password: String, completion: @escaping (Result) -> Void) {
        firebaseAuth.signIn(withEmail: email, password: password) { result, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }

            completion(.success(result?.user.uid ?? ""))
        }
    }

    public func logout() {
        do {
            try firebaseAuth.signOut()
        } catch {
            Snack.commonError()
        }
    }

    // MARK: Private

    private let firebaseAuth: Auth

    private let db: Firestore
}
