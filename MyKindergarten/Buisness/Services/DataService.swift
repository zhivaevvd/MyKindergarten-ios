//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation
import KeychainAccess

// MARK: - DataService

public protocol DataService: AnyObject {
    var appState: AppState { get set }
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

    // MARK: Private

    private enum Keys: String {
        case accessToken
    }

    private let keychain: Keychain
}
