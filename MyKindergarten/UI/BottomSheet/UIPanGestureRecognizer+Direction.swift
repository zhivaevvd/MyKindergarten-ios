//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

// MARK: - PanDirection

enum PanDirection: Int {
    case up, down, left, right

    // MARK: Internal

    var isVertical: Bool { [.up, .down].contains(self) }
    var isHorizontal: Bool { !isVertical }
}

extension UIPanGestureRecognizer {
    var direction: PanDirection? {
        let velocity = velocity(in: view)
        let isVertical = abs(velocity.y) > abs(velocity.x)
        switch (isVertical, velocity.x, velocity.y) {
        case (true, _, let y) where y < 0:
            return .up
        case (true, _, let y) where y > 0:
            return .down
        case (false, let x, _) where x > 0:
            return .right
        case (false, let x, _) where x < 0:
            return .left
        default:
            return nil
        }
    }
}
