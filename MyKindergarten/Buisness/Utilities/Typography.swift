//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

// MARK: - Typographyable

public protocol Typographyable {
    func apply(_ style: Typography)
}

// MARK: - Typography

public struct Typography {
    public let font: UIFont
    public let lineHeight: CGFloat
    public let color: UIColor

    public static func heading1Medium(_ color: UIColor = Asset.grayScaleBlack.color) -> Typography {
        .init(font: .systemFont(ofSize: 24, weight: .medium), lineHeight: 28, color: color)
    }

    public static func heading2Medium(_ color: UIColor = Asset.grayScaleBlack.color) -> Typography {
        .init(font: .systemFont(ofSize: 20, weight: .medium), lineHeight: 28, color: color)
    }

    public static func heading3Medium(_ color: UIColor = Asset.grayScaleBlack.color) -> Typography {
        .init(font: .systemFont(ofSize: 18, weight: .medium), lineHeight: 28, color: color)
    }

    public static func body1Regular(_ color: UIColor = Asset.grayScaleBlack.color) -> Typography {
        let font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return .init(font: font, lineHeight: lineHeight(font), color: color)
    }

    public static func body1Medium(_ color: UIColor = Asset.grayScaleBlack.color) -> Typography {
        let font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return .init(font: font, lineHeight: lineHeight(font), color: color)
    }

    public static func body2Regular(_ color: UIColor = Asset.grayScaleBlack.color) -> Typography {
        let font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return .init(font: font, lineHeight: lineHeight(font), color: color)
    }

    public static func body2Medium(_ color: UIColor = Asset.grayScaleBlack.color) -> Typography {
        let font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return .init(font: font, lineHeight: lineHeight(font), color: color)
    }

    public static func caption2Regular(_ color: UIColor = Asset.grayScaleBlack.color) -> Typography {
        let font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return .init(font: font, lineHeight: lineHeight(font), color: color)
    }

    public static func caption2Medium(_ color: UIColor = Asset.grayScaleBlack.color) -> Typography {
        let font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return .init(font: font, lineHeight: lineHeight(font), color: color)
    }

    public static func caption3Regular(_ color: UIColor = Asset.grayScaleBlack.color) -> Typography {
        let font = UIFont.systemFont(ofSize: 10, weight: .regular)
        return .init(font: font, lineHeight: lineHeight(font), color: color)
    }

    public static func caption3Medium(_ color: UIColor = Asset.grayScaleBlack.color) -> Typography {
        let font = UIFont.systemFont(ofSize: 10, weight: .medium)
        return .init(font: font, lineHeight: lineHeight(font), color: color)
    }

    public static func lineHeight(_ font: UIFont) -> CGFloat {
        switch font {
        case .systemFont(ofSize: 24, weight: .medium):
            return 28
        case .systemFont(ofSize: 20, weight: .medium),
             .systemFont(ofSize: 18, weight: .medium),
             .systemFont(ofSize: 16, weight: .regular),
             .systemFont(ofSize: 16, weight: .medium):
            return 24
        case .systemFont(ofSize: 14, weight: .regular),
             .systemFont(ofSize: 14, weight: .medium):
            return 20
        case .systemFont(ofSize: 12, weight: .regular),
             .systemFont(ofSize: 12, weight: .medium):
            return 16
        case .systemFont(ofSize: 10, weight: .regular),
             .systemFont(ofSize: 10, weight: .medium):
            return 12
        default:
            return font.lineHeight
        }
    }
}
