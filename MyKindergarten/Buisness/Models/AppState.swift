//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation

struct AppState {
    var accessToken: String?

    var isUserAuthenticated: Bool {
        !(accessToken ?? "").isEmpty
    }
}
