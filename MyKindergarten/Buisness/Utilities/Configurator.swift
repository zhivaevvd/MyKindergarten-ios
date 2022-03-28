//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

// MARK: - Configurator

public protocol Configurator {}

// MARK: - NSObject + Configurator

extension NSObject: Configurator {}

public extension Configurator where Self: UIView {
    @discardableResult
    @inlinable
    func configureWithAutoLayout(with configurator: (Self) -> Void) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        configurator(self)
        return self
    }
}
