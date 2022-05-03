//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Combine
import UIKit

// MARK: - InputField

open class InputField: UIView, InputFieldUIConfigurator {
    // MARK: Lifecycle

    public init(
        colorStyle: InputFieldColorStyle = InputFieldColorStyles.default,
        leftMargin: CGFloat = 14,
        rightMargin: CGFloat = 0,
        placeholder: String = ""
    ) {
        defer { self.colorStyle = colorStyle; self.placeholder = placeholder }
        self.colorStyle = colorStyle
        self.leftMargin = leftMargin
        self.rightMargin = rightMargin
        super.init(frame: .zero)
        textFieldContainer.layer.cornerRadius = 8
        self.placeholder = placeholder
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

    open var text: AnyPublisher<String?, Never> {
        innerText.removeDuplicates().eraseToAnyPublisher()
    }

    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard textInput.isUserInteractionEnabled else {
            return nil
        }

        let superHitView = super.hitTest(point, with: event)
        if textFieldContainer.point(inside: convert(point, to: textFieldContainer), with: event), !(superHitView is UIControl) {
            return textInput
        } else {
            return superHitView
        }
    }

    open func updateState(with text: String) {
        textInputTC.priority = UILayoutPriority(rawValue: text.isEmpty ? 250 : 750)
        let change: (inout InputFieldState) -> Void = text.isEmpty ?
            { $0.remove(.hasText); $0.insert(.isEmpty) } :
            { $0.remove(.isEmpty); $0.insert(.hasText) }
        updateCurrentState(change)
    }

    // MARK: Public

    public var becomeFRSideEffect: (() -> Void)?
    public var nextHandler: (() -> Void)?

    public var textInput: TextField = {
        let view = TextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()

    public var inputFieldFont = UIFont.systemFont(ofSize: 14, weight: .regular) {
        didSet {
            textInput.font = inputFieldFont
        }
    }

    public var placeholderFont = UIFont.systemFont(ofSize: 20, weight: .regular) {
        didSet {
            titleLabel.font = inputFieldFont
        }
    }

    public var isEmpty: Bool {
        state.contains(.isEmpty)
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

    var leftMargin: CGFloat // margins affect text container
    var rightMargin: CGFloat // margins affect text container
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
        let label = PaddingLabel()
        label.insets = .init(top: 0, left: 14, bottom: 0, right: 0)
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
        textFieldContainer.layer.borderWidth = 1
        textFieldContainer.layer.borderColor = uiProperties.containerBorderColor.cgColor
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

    @objc
    func textFieldEditingChanged() {
        innerText.send(textInput.currentText)
    }

    @objc
    func textFieldEditingDidBegin() {
        if textInput.subviews.contains(where: { String(describing: $0).contains("UIKBASPCoverView") }) {
            innerText.send("")
        }
    }

    func updateCurrentState(_ mutateState: @escaping (inout InputFieldState) -> Void) {
        var variableState = state
        mutateState(&variableState)
        state = variableState
    }

    // MARK: Private

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

// MARK: UITextFieldDelegate

extension InputField: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString text: String) -> Bool {
        if text.isEmpty, range.length == 0, range.location == 0 {
            defer {
                if let text = textField.text, let textRange = Range(range, in: text) {
                    textField.text = text.replacingCharacters(in: textRange, with: "")
                }
            }
            return true
        }

        guard text != "\n" else {
            nextHandler?()
            return false
        }
        guard let currentString = textField.text as NSString? else {
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
