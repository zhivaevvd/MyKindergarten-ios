//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

// MARK: - TeacherCardVC

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
        mainView.scrollView.delegate = self
        mainView.chatButton.setAction(for: .touchUpInside) {
            Router.push(navContr: self.navigationController, VCFactory.buildChatVC())
        }
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.titleView = titleView
        navigationDidAppear(appear: mainView.scrollView.contentOffset.y > mainView.avatarViewHeight * 0.69)
    }

    override public func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.tintColor = Asset.grayScaleBlack.color
    }

    // MARK: Public

    override public func loadView() {
        view = mainView
    }

    // MARK: Private

    private let teacher: Teacher

    private let mainView = TeacherCardView()

    private lazy var titleView = UIView().configureWithAutoLayout {
        $0.addSubview(titleLabel)
        titleLabel.centerX().centerY()
    }

    private lazy var titleLabel = Label(.body1Regular()).configureWithAutoLayout {
        $0.compressionResistance(253, .horizontal)
        $0.text = teacher.name
    }

    private func navigationDidAppear(appear: Bool) {
        let newAlpha: CGFloat = appear ? 1.0 : 0.0
        let navBarImage: UIImage? = appear ? nil : UIImage()

        UIView.animate(withDuration: 0.16) { [weak self] in
            guard let self = self else { return }
            self.titleLabel.alpha = newAlpha
            self.navigationController?.navigationBar.shadowImage = navBarImage
            self.navigationController?.navigationBar.setBackgroundImage(navBarImage, for: .default)
        }
    }
}

// MARK: UIScrollViewDelegate

extension TeacherCardVC: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navigationDidAppear(appear: scrollView.contentOffset.y > mainView.avatarViewHeight * 0.69)
    }
}
