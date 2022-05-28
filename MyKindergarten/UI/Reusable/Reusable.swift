//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ReusableView

public protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        String(describing: self)
    }
}

// MARK: - UITableViewCell + ReusableView

public extension ReusableView where Self: UITableViewCell {
    static var defaultReuseIdentifier: String {
        String(describing: self)
    }
}

// MARK: - UITableViewHeaderFooterView + ReusableView

public extension ReusableView where Self: UITableViewHeaderFooterView {
    static var defaultReuseIdentifier: String {
        String(describing: self)
    }
}

// MARK: - UICollectionReusableView + ReusableView

public extension ReusableView where Self: UICollectionReusableView {
    static var defaultReuseIdentifier: String {
        String(describing: self)
    }
}

public extension UITableView {
    func register(_ types: ReusableView.Type...) {
        types.forEach {
            register($0.self, forCellReuseIdentifier: $0.defaultReuseIdentifier)
        }
    }

    func register<T>(_: T.Type) where T: ReusableView {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

    func dequeueReusableCell<T>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }

        return cell
    }

    func registerHeaderFooter<T>(_ class: T.Type) where T: ReusableView {
        register(`class`, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
    }

    func dequeueReusableHeaderFooter<T: UITableViewHeaderFooterView & ReusableView>(_: T.Type) -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.defaultReuseIdentifier) as? T else {
            fatalError("Could not dequeue header/footer with identifier: \(T.defaultReuseIdentifier)")
        }

        return view
    }
}
