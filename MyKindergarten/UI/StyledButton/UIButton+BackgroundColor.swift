//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

public extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
            if let context = UIGraphicsGetCurrentContext() {
                context.setFillColor(color.cgColor)
                context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
                let colorImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                self.setBackgroundImage(colorImage, for: forState)
            }
        }
    }
}
