//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

public protocol InputFieldUIConfigurator {
    func handleError(text: String?)

    func configureLayout()

    func configureTextInput()

    var errorView: UIView { get }

    var fieldHeight: CGFloat { get }

    var fieldToError: CGFloat { get }

    var titlePosition: CGFloat { get }

    var placeholderPosition: CGFloat { get }

    func titleLabelShouldChangeStyleForTop()

    func titleLabelShouldChangeStyleForCenter()

    func setupErrorLabelProperties()
}
