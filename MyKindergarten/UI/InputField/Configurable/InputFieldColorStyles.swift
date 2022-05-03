//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation

public enum InputFieldColorStyles: InputFieldColorStyle {
    case `default`
    case digit

    // MARK: Public

    public func uiProperties(by state: InputFieldState, currentValue: String? = nil) -> InputFieldUIProperties {
        switch self {
        case .default:
            return InputFieldUIProperties(
                placeholderPosition: defaultPlaceholderPosition(for: state),
                containerColor: state.contains(.focused) ? .white : Asset.grayScaleLightGray.color,
                containerBorderColor: state.contains(.hasError) ?
                    Asset.alertsDanger.color :
                    (state.contains(.focused) ? Asset.borderBlack.color : Asset.grayScaleLightGray.color),
                containerBorderWidth: state.contains(.focused) || state.contains(.hasError) ? 1 : 0,
                cursorColor: state.contains(.hasError) ? Asset.alertsDanger.color : Asset.borderBlack.color
            )
        case .digit:
            return InputFieldUIProperties(
                placeholderPosition: .topTitle,
                containerColor: state.contains(.focused) ? .white : Asset.grayScaleLightGray.color,
                containerBorderColor: state.contains(.hasError) ?
                    Asset.alertsDanger.color :
                    (state.contains(.focused) || !((currentValue ?? "").isEmpty)) ? Asset.borderBlack.color : Asset
                    .grayScaleLightGray.color,
                containerBorderWidth: state.contains(.focused) || state.contains(.hasError) ? 1 : 0,
                cursorColor: state.contains(.hasError) ? Asset.alertsDanger.color : Asset.borderBlack.color
            )
        }
    }

    // MARK: Private

    private func defaultPlaceholderPosition(for state: InputFieldState) -> InputFieldPlaceholderPosition {
        state.contains(.focused) ? .topTitle : (state.contains(.isEmpty) ? .emptyCenter : .topTitle)
    }
}
