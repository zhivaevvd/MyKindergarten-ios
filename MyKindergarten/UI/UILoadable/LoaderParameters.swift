//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

public struct LoaderParameters {
    // MARK: Lifecycle

    public init(
        color: UIColor,
        diameter: CGFloat,
        strokeThickness: CGFloat,
        installConstraints: Bool = true,
        isBlocker: Bool
    ) {
        self.color = color
        self.diameter = diameter
        self.strokeThickness = strokeThickness
        self.installConstraints = installConstraints
        self.isBlocker = isBlocker
    }

    // MARK: Public

    public static let empty = LoaderParameters(
        color: UIColor.clear,
        diameter: 0.0,
        strokeThickness: 0.0,
        installConstraints: true,
        isBlocker: false
    )

    public let color: UIColor
    public let diameter: CGFloat
    public let strokeThickness: CGFloat
    public var installConstraints: Bool = true
    public let isBlocker: Bool
}
