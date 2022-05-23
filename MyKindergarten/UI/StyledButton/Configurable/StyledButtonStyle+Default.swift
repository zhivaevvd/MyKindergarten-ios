//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

public extension StyledButtonStyle {
    static let darkGray44 = StyledButtonStyle(
        font: .systemFont(ofSize: 14, weight: .medium),
        disabledFont: .systemFont(ofSize: 14, weight: .medium),
        background: StyledButtonStateColor(
            enabledColor: Asset.grayScaleDarkGray.color,
            disabledColor: Asset.grayScaleMediumGrey.color,
            pressedColor: Asset.grayScaleDarkGray.color.withAlphaComponent(0.9)
        ),
        text: .difficult(.white, Asset.grayScaleBorderGray.color),
        border: .plain(UIColor.clear),
        borderWidth: 0,
        cornerRadius: 8,
        buttonHeight: 44,
        loaderStyle: .white
    )

    static let lightGray44 = StyledButtonStyle(
        font: .systemFont(ofSize: 14, weight: .medium),
        disabledFont: .systemFont(ofSize: 14, weight: .medium),
        background: StyledButtonStateColor(
            enabledColor: Asset.grayScaleBorderGray.color,
            disabledColor: Asset.grayScaleBorderGray.color,
            pressedColor: Asset.grayScaleBorderGray.color.withAlphaComponent(0.9)
        ),
        text: .difficult(Asset.grayScaleBlack.color, Asset.grayScaleMediumGrey.color),
        border: .plain(UIColor.clear),
        borderWidth: 0,
        cornerRadius: 8,
        buttonHeight: 44,
        loaderStyle: .gray
    )

    static let red44 = StyledButtonStyle(
        font: .systemFont(ofSize: 14, weight: .medium),
        disabledFont: .systemFont(ofSize: 14, weight: .medium),
        background: StyledButtonStateColor(
            enabledColor: Asset.alertsDanger.color,
            disabledColor: Asset.alertsDanger.color,
            pressedColor: Asset.alertsDanger.color.withAlphaComponent(0.9)
        ),
        text: .difficult(.white, Asset.grayScaleMediumGrey.color),
        border: .plain(.clear),
        borderWidth: 0,
        cornerRadius: 9,
        buttonHeight: 44,
        loaderStyle: .gray
    )

    static let plainGrayText = StyledButtonStyle(
        font: .systemFont(ofSize: 14),
        disabledFont: .systemFont(ofSize: 14),
        background: .plain(.clear),
        text: .plain(Asset.grayScaleMediumGrey.color),
        border: .plain(.clear),
        borderWidth: 0,
        cornerRadius: 0,
        buttonHeight: 20,
        loaderStyle: .white
    )

    static let plainBlueText = StyledButtonStyle(
        font: .systemFont(ofSize: 16, weight: .medium),
        disabledFont: .systemFont(ofSize: 16, weight: .medium),
        background: .plain(.clear),
        text: .plain(Asset.alertsInfo.color),
        border: .plain(.clear),
        borderWidth: 0,
        cornerRadius: 0,
        buttonHeight: 24,
        loaderStyle: .white
    )

    static let plainBlackText = StyledButtonStyle(
        font: .systemFont(ofSize: 14),
        disabledFont: .systemFont(ofSize: 14),
        background: .plain(.clear),
        text: .plain(Asset.grayScaleBlack.color),
        border: .plain(.clear),
        borderWidth: 0,
        cornerRadius: 0,
        buttonHeight: 20,
        loaderStyle: .white
    )
}
