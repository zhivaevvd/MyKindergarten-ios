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
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func loadView() {
        view = mainView
    }

    // MARK: Private
    
    private let mainView = ScheduleItemView()

    private let vm: ScheduleItemViewModel

    private var subscriptions = Set<AnyCancellable>()

    private func configureBindings() {}
}
