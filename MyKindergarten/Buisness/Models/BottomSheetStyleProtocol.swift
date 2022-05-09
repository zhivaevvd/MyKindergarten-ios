//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

// MARK: - BottomSheetStyleProtocol

public protocol BottomSheetStyleProtocol {}

// MARK: - BottomSheetParametersProtocol

public protocol BottomSheetParametersProtocol {
    var shouldDismissOnTapOut: Bool { get }
    var contentView: UIView { get }
    var contentInsets: UIEdgeInsets { get }
    var customTapOutAction: (() -> Void)? { get }
    var onEveryTapOut: (() -> Void)? { get }
}
