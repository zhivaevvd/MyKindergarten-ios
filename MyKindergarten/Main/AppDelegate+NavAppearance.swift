//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

// import UIKit
//
// extension AppDelegate {
//    func configureNavigationBar() {
//        let appearance = UINavigationBar.appearance()
//        appearance.tintColor = .black
//        appearance.barTintColor = .white
//
//        appearance.titleTextAttributes = [
//            NSAttributedString.Key.foregroundColor: UIColor.black,
//            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .medium),
//        ]
//
////        appearance.backIndicatorImage = CommonAssets.iconNavBack.image.withInsets(.init(top: 0, left: 8, bottom: 0, right: 0))
////        appearance.backIndicatorTransitionMaskImage = CommonAssets.iconNavBack.image.withInsets(.init(top: 0, left: 8, bottom: 0, right: 0))
//        appearance.shadowImage = UIImage()
//        appearance.layoutMargins.left = 16
//        appearance.layoutMargins.right = 16
//        appearance.prefersLargeTitles = false
//    }
// }

import UIKit

extension AppDelegate {
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .medium),
        ]
        appearance.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .medium),
        ]

        let font = UIFont.systemFont(ofSize: 14, weight: .medium)
        let barButtonAppearance = UIBarButtonItemAppearance()
        barButtonAppearance.configureWithDefault(for: .plain)
        barButtonAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.blue,
            NSAttributedString.Key.font: font,
        ]
        barButtonAppearance.highlighted.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.blue,
            NSAttributedString.Key.font: font,
        ]
        appearance.buttonAppearance = barButtonAppearance

        appearance.backgroundColor = .white
//        appearance.setBackIndicatorImage(Asset.navBack.image, transitionMaskImage: Asset.navBack.image)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
}
