//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

public final class StyledButton: UIButton, StyledButtonLoadable {
    // MARK: Lifecycle

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("NSCoder init doesn't support")
    }

    public init(style: StyledButtonStyle, title: String, action: (() -> Void)? = nil) {
        self.style = style
        self.title = title
        self.action = action
        super.init(frame: CGRect.zero)
        set(style: style, title: title)
        layer.cornerRadius = style.cornerRadius
        layer.masksToBounds = true

        translatesAutoresizingMaskIntoConstraints = false
        let hConstr = heightAnchor.constraint(equalToConstant: style.buttonHeight)
        hConstr.priority = .init(999)
        hConstr.isActive = true

        if action != nil {
            addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        }
    }

    // MARK: Public

    public var isLoading: Bool = false {
        didSet {
            isLoading ? startLoading(shouldUpdate: !oldValue) : stopLoading(shouldUpdate: oldValue)
        }
    }

    public private(set) var style: StyledButtonStyle {
        didSet {
            setDefaultAttributedTitle()
            titleLabel?.numberOfLines = 1
            setBackgroundColor(color: style.background.enabledColor, forState: .normal)
            setBackgroundColor(color: style.background.disabledColor, forState: .disabled)
            setBackgroundColor(color: style.background.pressedColor, forState: .highlighted)
        }
    }

    override public func setTitle(_ title: String?, for _: UIControl.State) {
        self.title = title ?? ""
        setDefaultAttributedTitle()
    }

    public func set(style: StyledButtonStyle? = nil, title: String? = nil) {
        stopLoadingProgress()
        if let style = style {
            self.style = style
        }
        if let title = title {
            _title = title
        }
        setTitle(title ?? self.title, for: .normal)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        var borderColor = UIColor.clear.cgColor
        switch state {
        case .normal:
            borderColor = style.border.enabledColor.cgColor
        case .disabled:
            borderColor = style.border.disabledColor.cgColor
        case .highlighted:
            borderColor = style.border.pressedColor.cgColor
        default:
            break
        }
        layer.borderColor = borderColor
        layer.borderWidth = style.borderWidth
    }

    // MARK: Private

    private var action: (() -> Void)?

    private var title: String = ""

    private var _title: String = ""

    private var _image: UIImage?

    @objc
    private func handleTap() {
        action?()
    }

    private func setDefaultAttributedTitle() {
        setAttributedTitle(attributedString(with: style.text.enabledColor), for: .normal)
        setAttributedTitle(attributedString(with: style.text.disabledColor), for: .disabled)
        setAttributedTitle(attributedString(with: style.text.pressedColor), for: .highlighted)
    }

    // MARK: - Private methods

    private func startLoading(shouldUpdate: Bool) {
        guard shouldUpdate else {
            return
        }
        _title = title
        _image = image(for: .normal)
        setImage(nil, for: .normal)
        setTitle(nil, for: .normal)
        startLoading(with: style.loaderStyle)
    }

    private func stopLoading(shouldUpdate: Bool) {
        guard shouldUpdate else {
            return
        }
        title = _title
        setImage(_image, for: .normal)
        setTitle(_title, for: .normal)
        stopLoadingProgress()
    }

    private func attributedString(with textColor: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: title)
        let fullRange = NSRange(location: 0, length: title.utf16.count)
        attributedString.addAttribute(.font, value: isEnabled ? style.font : style.disabledFont, range: fullRange)
        attributedString.addAttribute(.foregroundColor, value: textColor, range: fullRange)
        return attributedString
    }
}
