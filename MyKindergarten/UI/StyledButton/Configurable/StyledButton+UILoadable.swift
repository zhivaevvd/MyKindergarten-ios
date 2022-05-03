//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation

public extension StyledButton {
    func startLoading(with parameters: StyledButtonLoaderStyle) {
        (self as UILoadable).startLoading(with: parameters.asLoaderParameters)
    }

    func stopLoadingProgress() {
        (self as UILoadable).stopLoadingProgress()
    }
}
