//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

public protocol BottomSheetStyle: BottomSheetStyleProtocol {
    var cornerRadius: CGFloat { get }
    var backgroundColor: UIColor { get }
    var arrowSize: CGSize { get }
    var arrowCornerRadius: CGFloat { get }
    var arrowColor: UIColor { get }
    var arrowTopOffset: CGFloat { get }
    var arrowToContent: CGFloat { get }
    var bottomSheetTopOffset: CGFloat { get }
}
