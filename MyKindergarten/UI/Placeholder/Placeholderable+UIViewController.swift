//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

// MARK: - UIViewController + Placeholderable

extension UIViewController: Placeholderable {}
public extension Placeholderable where Self: UIViewController {
    func showPlaceholder(with parameters: PlaceholderParameters) {
        view.showPlaceholder(with: parameters)
    }

    func hidePlaceholder() {
        view.hidePlaceholder()
    }
}
