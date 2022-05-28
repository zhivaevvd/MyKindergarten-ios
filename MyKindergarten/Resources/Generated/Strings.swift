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
        /// Закрыть
        public static let close = L10n.tr("Localizable", "common.close")
        /// Неверная дата
        public static let invalidDate = L10n.tr("Localizable", "common.invalidDate")
    }

    public enum Groups {
        /// Первая младшая
        public static let firstJun = L10n.tr("Localizable", "groups.firstJun")
        /// Средняя
        public static let middle = L10n.tr("Localizable", "groups.middle")
        /// Подготовительная
        public static let preparatory = L10n.tr("Localizable", "groups.preparatory")
        /// Вторая младшая
        public static let secondJun = L10n.tr("Localizable", "groups.secondJun")
        /// Старшая
        public static let senior = L10n.tr("Localizable", "groups.senior")
    }

    public enum Profile {
        /// Адрес дошкольного учреждения
        public static let address = L10n.tr("Localizable", "profile.address")
        /// Да, выйти
        public static let confirmLogout = L10n.tr("Localizable", "profile.confirmLogout")
        /// Группа
        public static let group = L10n.tr("Localizable", "profile.group")
        /// Для изменения личных данных обратитесь в администрацию дошкольного учреждения
        public static let infoDescription = L10n.tr("Localizable", "profile.infoDescription")
        /// Информация
        public static let information = L10n.tr("Localizable", "profile.information")
        /// Хотите изменить данные?
        public static let infoTitle = L10n.tr("Localizable", "profile.infoTitle")
        /// Логин для входа
        public static let login = L10n.tr("Localizable", "profile.login")
        /// Выйти
        public static let logout = L10n.tr("Localizable", "profile.logout")
        /// Пароль для входа
        public static let password = L10n.tr("Localizable", "profile.password")
        /// Вы действительно хотите выйти?
        public static let warning = L10n.tr("Localizable", "profile.warning")
    }

    public enum Schedule {
        /// О направлении
        public static let about = L10n.tr("Localizable", "schedule.about")
        /// Достижения
        public static let achievments = L10n.tr("Localizable", "schedule.achievments")
        /// Повышение квалификации
        public static let advancedTraining = L10n.tr("Localizable", "schedule.advancedTraining")
        /// Образование
        public static let education = L10n.tr("Localizable", "schedule.education")
        /// Посмотреть руководство
        public static let showRecomendations = L10n.tr("Localizable", "schedule.showRecomendations")
        /// Задания
        public static let tasks = L10n.tr("Localizable", "schedule.tasks")
        /// Педагог
        public static let teacherTitle = L10n.tr("Localizable", "schedule.teacherTitle")

        /// Аттестация: %@
        public static func attestation(_ p1: Any) -> String {
            L10n.tr("Localizable", "schedule.attestation", String(describing: p1))
        }

        /// Опыт: %@ лет
        public static func experience(_ p1: Any) -> String {
            L10n.tr("Localizable", "schedule.experience", String(describing: p1))
        }

        /// Группа: %@
        public static func group(_ p1: Any) -> String {
            L10n.tr("Localizable", "schedule.group", String(describing: p1))
        }

        /// Должность: %@
        public static func position(_ p1: Any) -> String {
            L10n.tr("Localizable", "schedule.position", String(describing: p1))
        }

        /// Воспитатель: %@
        public static func teacher(_ p1: Any) -> String {
            L10n.tr("Localizable", "schedule.teacher", String(describing: p1))
        }

        /// Неделя: %@
        public static func week(_ p1: Any) -> String {
            L10n.tr("Localizable", "schedule.week", String(describing: p1))
        }

        /// Тематика недели: %@
        public static func weekTheme(_ p1: Any) -> String {
            L10n.tr("Localizable", "schedule.weekTheme", String(describing: p1))
        }
    }

    public enum Tabbar {
        /// Профиль
        public static let profile = L10n.tr("Localizable", "tabbar.profile")
        /// Расписание
        public static let schedule = L10n.tr("Localizable", "tabbar.schedule")
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
