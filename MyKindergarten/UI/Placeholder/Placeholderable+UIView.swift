//
// FittyWork
// Copyright © 2022 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - UIView + Placeholderable

extension UIView: Placeholderable {}
public extension Placeholderable where Self: UIView {
    var existedPlaceholder: PlaceholderView? {
        subviews.first(where: { type(of: $0) == PlaceholderView.self }) as? PlaceholderView
    }

    func showPlaceholder(with parameters: PlaceholderParameters) {
        let placeholderView = existedPlaceholder ?? PlaceholderView()
        if placeholderView.superview == nil {
            addSubview(placeholderView)

            switch parameters.layout {
            case .default:
                NSLayoutConstraint.activate([
                    placeholderView.topAnchor.constraint(equalTo: topAnchor),
                    placeholderView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    placeholderView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    placeholderView.bottomAnchor.constraint(equalTo: bottomAnchor),
                ])
            case let .custom(layoutBuilder):
                layoutBuilder?(placeholderView)
            }
        }
        bringSubviewToFront(placeholderView)
        placeholderView.show(with: parameters)
    }

    func hidePlaceholder() {
        existedPlaceholder?.hide()
        existedPlaceholder?.removeFromSuperview()
    }
}
