//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

public extension LoaderParameters {
    static let dark = LoaderParameters(
        color: Asset.borderBlack.color,
        diameter: 44.0,
        strokeThickness: 2.0,
        installConstraints: true,
        isBlocker: false
    )

    static let smallDark = LoaderParameters(
        color: Asset.borderBlack.color,
        diameter: 20.0,
        strokeThickness: 1.5,
        installConstraints: true,
        isBlocker: false
    )
}
