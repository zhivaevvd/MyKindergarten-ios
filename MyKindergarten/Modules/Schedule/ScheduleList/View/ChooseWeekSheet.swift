//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import AutoLayoutSugar
import Combine
import UIKit

// MARK: - ChooseWeekSheet

final class ChooseWeekSheet: UIView, UIPickerViewDelegate {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        _date = source[0]
        configurePicker()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    private(set) var confirmButton = StyledButton(style: .plainBlueText, title: "Подтвердить").prepareForAutoLayout()

    var date: AnyPublisher<String, Never> {
        $_date.eraseToAnyPublisher()
    }

    // MARK: Private

    private var picker = UIPickerView().prepareForAutoLayout()

    private var source = ["23.05.2022-29.05.2022", "30.05.2022-05.06.2022"]

    @Published
    private var _date = String()

    private func configurePicker() {
        addSubviews([confirmButton, picker])
        picker.dataSource = self
        picker.delegate = self
        confirmButton.top().right()
        picker.left().right().top(to: .bottom(2), of: confirmButton).bottom()
    }
}

// MARK: UIPickerViewDataSource

extension ChooseWeekSheet: UIPickerViewDataSource {
    func numberOfComponents(in _: UIPickerView) -> Int {
        1
    }

    func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        source.count
    }

    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent _: Int) -> String? {
        String(source[row])
    }

    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
        _date = source[row]
    }
}
