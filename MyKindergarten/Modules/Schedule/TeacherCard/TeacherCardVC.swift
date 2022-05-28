//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

public final class TeacherCardVC: UIViewController {
    // MARK: Lifecycle

    public init(teacher: Teacher) {
        self.teacher = teacher
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        mainView.model = teacher
    }

    // MARK: Public

    override public func loadView() {
        view = mainView
    }

    // MARK: Private

    private let teacher: Teacher

    private let mainView = TeacherCardView()
}
