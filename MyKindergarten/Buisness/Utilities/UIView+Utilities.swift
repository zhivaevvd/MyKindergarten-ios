//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

public extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach {
            addSubview($0)
        }
    }

    static func separator() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        return view
    }
}
