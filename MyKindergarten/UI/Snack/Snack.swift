//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import TTGSnackbar
import UIKit

public enum Snack {
    // MARK: Public

    public static func noUserError() {
        let snack = TTGSnackbar(message: L10n.Auth.noUser, duration: .middle)
        showSnack(snack)
    }

    public static func authError(_ noInternet: Bool) {
        let snack = TTGSnackbar(message: noInternet ? L10n.Auth.noInterner : L10n.Auth.unknownError, duration: .middle)
        showSnack(snack)
    }

    public static func noInternet() {
        let snack = TTGSnackbar(message: L10n.Auth.noInterner, duration: .middle)
        showSnack(snack)
    }

    public static func commonError() {
        let snack = TTGSnackbar(message: "Произошла ошибка", duration: .middle)
        showSnack(snack)
    }

    // MARK: Private

    private static func showSnack(
        _ snack: TTGSnackbar,
        animationType: TTGSnackbarAnimationType = .slideFromLeftToRight,
        backgroundColor: UIColor = Asset.alertsDanger.color,
        textAlign: NSTextAlignment = .center
    ) {
        snack.animationType = animationType
        snack.backgroundColor = backgroundColor
        snack.messageTextAlign = textAlign
        snack.show()
    }
}
