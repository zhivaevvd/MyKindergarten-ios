//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation
import KeychainAccess

// MARK: - DataService

public protocol DataService: AnyObject {
    var appState: AppState { get set }
    var group: String? { get set }
}

// MARK: - DataServiceImpl

public final class DataServiceImpl: DataService {
    // MARK: Lifecycle

    init() {
        keychain = Keychain()
        appState = AppState(accessToken: keychain[Keys.accessToken.rawValue])
    }

    // MARK: Public

    public var appState: AppState {
        didSet {
            keychain[Keys.accessToken.rawValue] = appState.accessToken
        }
    }

//    public var user: User! {
//        get {
//            return UserDefaults.standard.object(forKey: Keys.user.rawValue) as? User
//        } set {
//            let defaults = UserDefaults.standard
//            if let user = newValue {
//                defaults.set(user, forKey: Keys.user.rawValue)
//            } else {
//                defaults.removeObject(forKey: Keys.user.rawValue)
//            }
//        }
//    }\

    public var group: String? {
        get {
            UserDefaults.standard.string(forKey: Keys.group.rawValue) ?? ""
        } set {
            let value = newValue
            UserDefaults.standard.set(value, forKey: "group")
        }
    }

    // MARK: Private

    private enum Keys: String {
        case accessToken
        case group
    }

    private let keychain: Keychain
}
