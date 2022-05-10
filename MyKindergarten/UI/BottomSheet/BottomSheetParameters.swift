//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

public struct BottomSheetParameters: BottomSheetParametersProtocol {
    // MARK: Lifecycle

    public init(
        shouldDismissOnTapOut: Bool = true,
        contentView: UIView,
        contentInsets: UIEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16),
        customTapOutAction: (() -> Void)? = nil,
        onEveryTapOut: (() -> Void)? = nil
    ) {
        self.shouldDismissOnTapOut = shouldDismissOnTapOut
        self.contentView = contentView
        self.contentInsets = contentInsets
        self.customTapOutAction = customTapOutAction
        self.onEveryTapOut = onEveryTapOut
    }

    // MARK: Public

    public var shouldDismissOnTapOut: Bool
    public var contentView: UIView
    public var contentInsets: UIEdgeInsets
    public var customTapOutAction: (() -> Void)?
    public var onEveryTapOut: (() -> Void)?
}
