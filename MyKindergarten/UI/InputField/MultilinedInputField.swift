//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Combine
import UIKit

// MARK: - MultilinedInputField

open class MultilinedInputField: UIView, InputFieldUIConfigurator {
    // MARK: Lifecycle

    public init(
        colorStyle: InputFieldColorStyle = InputFieldColorStyles.default,
        leftMargin: CGFloat = 0,
        rightMargin: CGFloat = 0,
        placeholder: String = ""
    ) {
        defer { self.colorStyle = colorStyle; self.placeholder = placeholder }
        self.colorStyle = colorStyle
        self.leftMargin = leftMargin
        self.rightMargin = rightMargin
        super.init(frame: .zero)
        configureTextInput()
        configureLayout()
        setupErrorLabelProperties()
        innerText
            .removeDuplicates()
            .sink { [weak self] textValue in
                self?.updateState(with: textValue ?? "")
            }
            .store(in: &subscriptions)
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("NSCoder init doesn't support")
    }

    // MARK: Open

    open func updateState(with text: String) {
        textInputTC.priority = UILayoutPriority(rawValue: text.isEmpty ? 250 : 750)
        let change: (inout InputFieldState) -> Void = text.isEmpty ?
            { $0.remove(.hasText); $0.insert(.isEmpty) } :
            { $0.remove(.isEmpty); $0.insert(.hasText) }
        updateCurrentState(change)
    }

    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if textInput.point(inside: convert(point, to: textInput), with: event) {
            return textInput
        } else {
            return super.hitTest(point, with: event)
        }
    }

    // MARK: Public

    public var becomeFRSideEffect: (() -> Void)?
    public var nextHandler: (() -> Void)?

    public var textInput: TextView = {
        let view = TextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()

    public var isEmpty: Bool {
        state.contains(.isEmpty)
    }

    public var text: AnyPublisher<String?, Never> {
        innerText.eraseToAnyPublisher()
    }

    public var error: PassthroughSubject<String?, Never>? {
        didSet {
            oldValue?.send(completion: .finished)
            error?
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { (_: Subscribers.Completion<Never>) in

                }, receiveValue: { [weak self] error in
                    guard let self = self else {
                        return
                    }
                    self.handleError(text: error)
                    self.updateCurrentState {
                        if error != nil {
                            $0.insert(.hasError)
                        } else {
                            $0.remove(.hasError)
                        }
                    }
                })
                .store(in: &subscriptions)
        }
    }

    public var placeholderFont = UIFont.systemFont(ofSize: 20, weight: .bold) {
        didSet {
            titleLabel.font = placeholderFont
        }
    }

    public var inputTextFont = UIFont.systemFont(ofSize: 20, weight: .bold) {
        didSet {
            textInput.font = inputTextFont
        }
    }

    public var placeholder: String = "" {
        didSet {
            titleLabel.text = placeholder
        }
    }

    public func bind(_ fieldModel: FieldModel) -> AnyCancellable {
        error = fieldModel.error
        return text.receive(on: DispatchQueue.main).sink { newText in
            fieldModel.setValue(newText)
        }
    }

    @discardableResult
    override public func becomeFirstResponder() -> Bool {
        textInput.becomeFirstResponder()
    }

    @discardableResult
    override public func resignFirstResponder() -> Bool {
        textInput.resignFirstResponder()
    }

    public func trim() {
        guard let text = textInput.text else {
            return
        }
        textInput.text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        innerText.send(textInput.text)
    }

    public func setText(_ text: String) {
        guard textInput.text != text else {
            return
        }
        textInput.text = text
        innerText.send(text)
    }

    // MARK: Internal

    let leftMargin: CGFloat // margins affect text container
    let rightMargin: CGFloat // margins affect text container
    var textInputTC: NSLayoutConstraint!

    var titleLabelTopConstraint: NSLayoutConstraint!

    private(set) lazy var textFieldContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        view.addSubview(textFieldContainerSeparator)

        NSLayoutConstraint.activate([
            textFieldContainerSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textFieldContainerSeparator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textFieldContainerSeparator.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        return view
    }()

    private(set) lazy var textFieldContainerSeparator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        textFieldContainerSeparatorHeight = view.heightAnchor.constraint(equalToConstant: 2)
        textFieldContainerSeparatorHeight?.isActive = true
        return view
    }()

    private(set) lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.adjustsFontSizeToFitWidth = true
        return view
    }()

    var becomeFRHandler: (() -> Void)?

    let innerText = PassthroughSubject<String?, Never>()

    private(set) lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func isInputField() -> Bool {
        true
    }

    func updateStateOnBecomeFirstResponder() {
        becomeFRHandler?()
        updateCurrentState {
            $0.remove(.nonFocused)
            $0.insert(.focused)
        }
    }

    func updateStateOnResignFirstResponder() {
        updateCurrentState { $0.insert(.nonFocused); $0.remove(.focused) }
    }

    func _apply(uiProperties: InputFieldUIProperties) {
        textFieldContainer.backgroundColor = uiProperties.containerColor
        textFieldContainerSeparatorHeight?.constant = uiProperties.containerBorderWidth
        textFieldContainerSeparator.backgroundColor = uiProperties.containerBorderColor
        textInput.tintColor = uiProperties.cursorColor
        switch uiProperties.placeholderPosition {
        case .topTitle:
            titleLabelTopConstraint?.constant = titlePosition
            titleLabelShouldChangeStyleForTop()
            textInput.isHidden = false
        case .emptyCenter:
            titleLabelTopConstraint?.constant = placeholderPosition
            titleLabelShouldChangeStyleForCenter()
            textInput.isHidden = true
        }
    }

    func updateCurrentState(_ mutateState: @escaping (inout InputFieldState) -> Void) {
        var variableState = state
        mutateState(&variableState)
        state = variableState
    }

    // MARK: Private

    private var heightFor5Lines: CGFloat = 0

    private var textFieldContainerSeparatorHeight: NSLayoutConstraint?

    private var subscriptions = Set<AnyCancellable>()

    private var initialUpdate: Bool = true

    private var state: InputFieldState = [.isEmpty, .nonFocused] {
        didSet {
            apply(uiProperties: colorStyle.uiProperties(by: state))
        }
    }

    private var colorStyle: InputFieldColorStyle {
        didSet {
            apply(uiProperties: colorStyle.uiProperties(by: state))
        }
    }

    private func apply(uiProperties: InputFieldUIProperties, animated: Bool = true) {
        if animated, !initialUpdate {
            UIView.animate(withDuration: 0.16) { [weak self] () in
                self?._apply(uiProperties: uiProperties)
                self?.layoutIfNeeded()
            }
        } else {
            UIView.performWithoutAnimation { [weak self] () in
                self?._apply(uiProperties: uiProperties)
            }
            initialUpdate = false
        }
    }
}

// MARK: UITextViewDelegate

extension MultilinedInputField: UITextViewDelegate {
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text.isEmpty, range.length == 0, range.location == 0 {
            defer {
                if let text = textView.text, let textRange = Range(range, in: text) {
                    textView.text = text.replacingCharacters(in: textRange, with: "")
                }
            }
            return true
        }

        guard text != "\n" else {
            nextHandler?()
            return false
        }
        guard let currentString = textView.text as NSString? else {
            return false
        }

        let newString: NSString = currentString.replacingCharacters(in: range, with: text) as NSString
        let shouldChange = newString != currentString
        if shouldChange {
            innerText.send(newString as String)
        }
        return shouldChange
    }
}
