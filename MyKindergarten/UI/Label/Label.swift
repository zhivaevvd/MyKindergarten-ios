//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

open class Label: UILabel, Typographyable {
    // MARK: Lifecycle

    public convenience init(_ style: Typography) {
        self.init()
        font = style.font
        lineHeight = style.lineHeight
        textColor = style.color
    }

    // MARK: Open

    open var lineHeight: CGFloat?

    override open var font: UIFont! {
        didSet {
            defaultLineHeight = Typography.lineHeight(font)
        }
    }

    override open var attributedText: NSAttributedString? {
        get {
            super.attributedText
        } set {
            guard let attributedString = newValue else {
                super.attributedText = nil
                return
            }

            let mutableAttrString = NSMutableAttributedString(attributedString: attributedString)
            let paragraphStyle = NSMutableParagraphStyle()
            let lineHeightValue = lineHeight ?? defaultLineHeight
            paragraphStyle.minimumLineHeight = lineHeightValue
            paragraphStyle.maximumLineHeight = lineHeightValue

            paragraphStyle.lineBreakMode = lineBreakMode
            paragraphStyle.lineBreakStrategy = lineBreakStrategy
            paragraphStyle.alignment = textAlignment
            mutableAttrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, mutableAttrString.length))
            let baseOffset = (lineHeightValue - font.lineHeight) / 2 / 2
            mutableAttrString.addAttribute(.baselineOffset, value: baseOffset, range: NSMakeRange(0, mutableAttrString.length))

            super.attributedText = mutableAttrString
        }
    }

    override open var text: String? {
        get {
            attributedText?.string
        }
        set {
            guard let text = newValue else {
                attributedText = nil
                super.text = nil
                return
            }

            let mutableAttrString = NSMutableAttributedString(string: text)
            attributedText = mutableAttrString
        }
    }

    open func apply(_ style: Typography) {
        lineHeight = style.lineHeight
        font = style.font
        textColor = style.color
    }

    // MARK: Private

    private var defaultLineHeight: CGFloat = 20.287
}
