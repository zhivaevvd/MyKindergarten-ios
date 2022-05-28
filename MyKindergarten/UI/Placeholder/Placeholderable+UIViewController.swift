//
// FittyWork
// Copyright © 2022 Heads and Hands. All rights reserved.
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
