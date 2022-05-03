//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation

public extension StyledButtonLoaderStyle {
    static let white = StyledButtonLoaderStyle(
        color: .white,
        diameter: 18.0,
        strokeThickness: 2.0,
        installConstraints: true,
        isBlocker: false
    )

    static let gray = StyledButtonLoaderStyle(
        color: Asset.grayScaleDarkGray.color,
        diameter: 18.0,
        strokeThickness: 2.0,
        installConstraints: true,
        isBlocker: false
    )

    var asLoaderParameters: LoaderParameters {
        LoaderParameters(
            color: color,
            diameter: diameter,
            strokeThickness: strokeThickness,
            installConstraints: installConstraints,
            isBlocker: isBlocker
        )
    }
}
