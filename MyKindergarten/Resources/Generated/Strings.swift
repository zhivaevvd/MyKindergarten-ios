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
public enum L10n {
    public enum Auth {
        public enum BottomSheet {
            /// Для восстановления доступа к аккаунту обратитесь к администрации детского сада
            public static let message = L10n.tr("Localizable", "auth.bottomSheet.message")
            /// Не удается войти?
            public static let title = L10n.tr("Localizable", "auth.bottomSheet.title")
        }

        public enum CantLogIn {
            /// Свяжитесь с администрацией вашего детского сада чтобы восстановить доступ
            public static let description = L10n.tr("Localizable", "auth.cantLogIn.description")
            /// Не можете войти?
            public static let title = L10n.tr("Localizable", "auth.cantLogIn.title")
        }

        /// Вход доступен только для родителей детского сада
        public static let description = L10n.tr("Localizable", "auth.description")
        /// E-mail
        public static let email = L10n.tr("Localizable", "auth.email")
        /// Войти
        public static let logIn = L10n.tr("Localizable", "auth.logIn")
        /// Нет соединения
        public static let noInterner = L10n.tr("Localizable", "auth.noInterner")
        /// Network error (such as timeout, interrupted connection or unreachable host) has occurred.
        public static let noInternetError = L10n.tr("Localizable", "auth.noInternetError")
        /// Такого пользователя не существует
        public static let noUser = L10n.tr("Localizable", "auth.noUser")
        /// There is no user record corresponding to this identifier. The user may have been deleted.
        public static let noUserError = L10n.tr("Localizable", "auth.noUserError")
        /// Пароль
        public static let password = L10n.tr("Localizable", "auth.password")
        /// Номер телефона
        public static let phone = L10n.tr("Localizable", "auth.phone")
        /// Авторизация
        public static let title = L10n.tr("Localizable", "auth.title")
        /// Неизвестная ошибка
        public static let unknownError = L10n.tr("Localizable", "auth.unknownError")
        /// Поле заполнено неверно
        public static let wrongField = L10n.tr("Localizable", "auth.wrongField")
    }

    public enum Common {
        /// Дата рождения
        public static let bdate = L10n.tr("Localizable", "common.bdate")
        /// Неверная дата
        public static let invalidDate = L10n.tr("Localizable", "common.invalidDate")
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
