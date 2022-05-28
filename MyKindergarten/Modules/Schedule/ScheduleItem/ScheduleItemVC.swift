//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Combine
import UIKit

public final class ScheduleItemVC: UIViewController {
    // MARK: Lifecycle

    public init(vm: ScheduleItemViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        configureBindings()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        mainView.teacherDidTap = { [weak self] teacher in
            guard let navContr = self?.navigationController else { return }
            self?.vm.showTeacherCard(teacher, navContr: navContr)
        }
    }

    // MARK: Public

    override public func loadView() {
        view = mainView
    }

    // MARK: Private

    private let mainView = ScheduleItemView()

    private let vm: ScheduleItemViewModel

    private var subscriptions = Set<AnyCancellable>()

    private func configureBindings() {
        mainView.model = vm.scheduleItem
    }
}
