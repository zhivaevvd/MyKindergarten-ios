//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation

public struct AppState {
    var accessToken: String?
    var user: User?

    var isUserAuthenticated: Bool {
        !(accessToken ?? "").isEmpty
    }
}
