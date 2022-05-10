//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import UIKit

public final class PresentationController: UIPresentationController {
    // MARK: Public

    public var hasTopShadow = false

    override public var frameOfPresentedViewInContainerView: CGRect {
        frame
    }

    public var frame: CGRect {
        containerView?.frame ?? CGRect.zero
    }

    override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        guard let containerView = containerView else {
            return
        }

        coordinator.animate(
            alongsideTransition: { [unowned self] _ in
                self.dimmingView.frame = containerView.bounds
            },
            completion: nil
        )
    }

    // MARK: - Actions

    public func updateDimmingView(alpha: CGFloat) {
        dimmingView.alpha = alpha
    }

    override public func presentationTransitionWillBegin() {
        guard let containerView = containerView, let presentedView = presentedView else {
            return
        }

        dimmingView.frame = containerView.bounds
        containerView.addSubview(dimmingView)
        containerView.addSubview(presentedView)

        if let transitionCoordinator = presentingViewController.transitionCoordinator {
            transitionCoordinator.animate(
                alongsideTransition: { [unowned self] _ in
                    self.dimmingView.alpha = 1.0
                },
                completion: nil
            )
        }
    }

    override public func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        guard let presentedView = presentedView else {
            return
        }

        presentedView.frame = frame

        guard hasTopShadow else { return }
        dimmingView.backgroundColor = .clear
        presentedView.layer.masksToBounds = false
        presentedView.layer.shadowColor = UIColor.black.cgColor
        presentedView.layer.shadowOffset = CGSize(width: 0, height: -1)
        presentedView.layer.shadowOpacity = 0.09
        presentedView.layer.shadowRadius = 4
    }

    override public func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            dimmingView.removeFromSuperview()
        }
    }

    override public func dismissalTransitionWillBegin() {
        if let transitionCoordinator = presentingViewController.transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: { [unowned self] _ in
                self.dimmingView.alpha = 0.0
            }, completion: nil)
        }
    }

    override public func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            dimmingView.removeFromSuperview()
        }
    }

    // MARK: Private

    private lazy var dimmingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Asset.grayScaleBlack.color.withAlphaComponent(0.5)
        view.alpha = 0.0
        view.isUserInteractionEnabled = true
        return view
    }()
}
