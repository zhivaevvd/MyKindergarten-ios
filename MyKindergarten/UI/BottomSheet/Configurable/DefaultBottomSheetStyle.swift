//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

public struct DefaultBottomSheetStyle: BottomSheetStyle {
    // MARK: Lifecycle

    public init(
        cornerRadius: CGFloat = 12,
        backgroundColor: UIColor = .white,
        arrowSize: CGSize = .init(width: 33, height: 4),
        arrowCornerRadius: CGFloat = 2.5,
        arrowColor: UIColor = Asset.grayScaleBorderGray.color,
        arrowTopOffset: CGFloat = 8,
        arrowToContent: CGFloat = 16,
        bottomSheetTopOffset: CGFloat = 0
    ) {
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.arrowColor = arrowColor
        self.arrowSize = arrowSize
        self.arrowCornerRadius = arrowCornerRadius
        self.arrowTopOffset = arrowTopOffset
        self.arrowToContent = arrowToContent
        self.bottomSheetTopOffset = bottomSheetTopOffset
    }

    // MARK: Public

    public var cornerRadius: CGFloat
    public var backgroundColor: UIColor
    public var arrowSize: CGSize
    public var arrowCornerRadius: CGFloat
    public var arrowColor: UIColor
    public var arrowTopOffset: CGFloat
    public var arrowToContent: CGFloat
    public var bottomSheetTopOffset: CGFloat
}
