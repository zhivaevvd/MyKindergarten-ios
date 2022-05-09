// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {

  public enum Auth {
    /// Вход доступен только для родителей детского сада
    public static let description = L10n.tr("Localizable", "auth.description")
    /// E-mail
    public static let email = L10n.tr("Localizable", "auth.email")
    /// Войти
    public static let logIn = L10n.tr("Localizable", "auth.logIn")
    /// Пароль
    public static let password = L10n.tr("Localizable", "auth.password")
    /// Номер телефона
    public static let phone = L10n.tr("Localizable", "auth.phone")
    /// Авторизация
    public static let title = L10n.tr("Localizable", "auth.title")
    /// Поле заполнено неверно
    public static let wrongField = L10n.tr("Localizable", "auth.wrongField")
    public enum CantLogIn {
      /// Свяжитесь с администрацией вашего детского сада чтобы восстановить доступ
      public static let description = L10n.tr("Localizable", "auth.cantLogIn.description")
      /// Не можете войти?
      public static let title = L10n.tr("Localizable", "auth.cantLogIn.title")
    }
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
