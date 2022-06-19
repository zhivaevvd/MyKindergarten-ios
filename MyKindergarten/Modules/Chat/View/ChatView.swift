//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import AutoLayoutSugar
import UIKit

// MARK: - ChatView

final class ChatView: UIView {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        let endTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(endTap))
        addGestureRecognizer(endTapRecognizer)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    private(set) lazy var tableView = UITableView().configureWithAutoLayout {
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.backgroundColor = .white
        $0.register(ChatCell.self)
    }

    // MARK: Private

    private lazy var inView = UIView().configureWithAutoLayout {
        $0.backgroundColor = Asset.grayScaleLightGray.color
        $0.layer.cornerRadius = 8
    }

    private lazy var textField = UITextField().configureWithAutoLayout {
        $0.placeholder = "Введите сообщение"
        $0.delegate = self
    }

    private lazy var sendButton = UIButton(type: .system).configureWithAutoLayout {
        $0.setTitle("Отправить", for: .normal)
    }

    private var inViewBottom: NSLayoutConstraint?

    private func configureLayout() {
        addSubviews([tableView, inView])
        tableView.pinToSuperview()

        inView.addSubviews([textField, sendButton])

        textField.top(8).left(8).bottom()
        sendButton.right(8).centerY()
        textField.rightAnchor <~ sendButton.leftAnchor + 8

        inView.left().right().height(44)
        inViewBottom = inView.bottomAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor).activate()
    }

    @objc
    private func endTap() {
        endEditing(true)
    }
}

// MARK: UITextFieldDelegate

extension ChatView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_: UITextField) {
        inViewBottom?.constant = -264
    }

    func textFieldDidEndEditing(_: UITextField) {
        inViewBottom?.constant = 0
    }
}
