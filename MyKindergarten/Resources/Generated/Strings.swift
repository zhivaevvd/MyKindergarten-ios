//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// MARK: - L10n

// swiftlint:disable superfluous_disable_command file_length implicit_return

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
    internal enum Auth {
        internal enum CantLogIn {
            /// Свяжитесь с администрацией вашего детского сада чтобы восстановить доступ
            internal static let description = L10n.tr("Localizable", "auth.cantLogIn.description")
            /// Не можете войти?
            internal static let title = L10n.tr("Localizable", "auth.cantLogIn.title")
        }

        /// Войти
        internal static let logIn = L10n.tr("Localizable", "auth.logIn")
        /// Пароль
        internal static let password = L10n.tr("Localizable", "auth.password")
        /// Номер телефона
        internal static let phone = L10n.tr("Localizable", "auth.phone")
        /// Авторизация
        internal static let title = L10n.tr("Localizable", "auth.title")
    }
}

// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

// MARK: - BundleToken

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle: Bundle = {
        #if SWIFT_PACKAGE
            return Bundle.module
        #else
            return Bundle(for: BundleToken.self)
        #endif
    }()
}

// swiftlint:enable convenience_type