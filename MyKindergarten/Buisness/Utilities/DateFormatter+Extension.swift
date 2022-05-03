//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation

public extension DateFormatter {
    static let ruLocale = Locale(identifier: "ru_RU")

    static let requestFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssssss'Z'"
        return formatter
    }()

    /// Время в формате 14:40
    /// - parameter separator: разделитель
    static func time(from date: Date, separator: String = ":", locale: Locale = ruLocale) -> String {
        let df = DateFormatter()
        df.locale = locale
        df.dateFormat = "HH\(separator)mm"
        return df.string(from: date)
    }

    /// День недели краткий в формате: Ср
    static func weekdayShort(from date: Date, locale: Locale = ruLocale) -> String {
        let df = DateFormatter()
        df.locale = locale
        df.dateFormat = "E"
        return df.string(from: date)
    }

    // День недели в формате: Вторник
    static func weekdayFull(from date: Date, locale: Locale = ruLocale) -> String {
        let df = DateFormatter()
        df.locale = locale
        df.dateFormat = "EEEE"
        return df.string(from: date)
    }

    /// День в формате: 2
    static func day(from date: Date, locale: Locale = ruLocale) -> String {
        let df = DateFormatter()
        df.locale = locale
        df.dateFormat = "d"
        return df.string(from: date)
    }

    /// День и месяц в формате: 2 марта
    static func dateAndMonth(from date: Date, locale: Locale = ruLocale) -> String {
        let df = DateFormatter()
        df.locale = locale
        df.dateFormat = "d MMMM"
        return df.string(from: date)
    }

    /// Дата в формате 24.11
    ///  - parameter separator: разделитель
    static func dateAndMonthShort(from date: Date, separator: String = ".", locale: Locale = ruLocale) -> String {
        let df = DateFormatter()
        df.locale = locale
        df.dateFormat = "dd\(separator)MM"
        return df.string(from: date)
    }

    /// Дата в формате сегодня 16:30 /  вчера 11:00 / полная дата
    /// - parameter separator: разделитель
//    static func readableDateWithTime(from _date: Date, separator: String = ", ", locale _: Locale = ruLocale) -> String {
//        if Calendar.current.isDateInToday(_date) {
//            return "\(CommonStrings.today)\(separator)\(time(from: _date))"
//        } else if Calendar.current.isDateInYesterday(_date) {
//            return "\(CommonStrings.yestarday)\(separator)\(time(from: _date))"
//        } else {
//            return date(from: _date)
//        }
//    }

    /// Дата в формате 02.08.2022
    /// - parameter separator: разделитель
    static func date(from date: Date, separator: String = ".", locale: Locale = ruLocale) -> String {
        let df = DateFormatter()
        df.locale = locale
        df.dateFormat = "dd\(separator)MM\(separator)yyyy"
        return df.string(from: date)
    }

    /// Дата в формате 02 марта 2022
    /// - parameter separator: разделитель
    static func fullDate(from date: Date, separator: String = " ", locale: Locale = ruLocale) -> String {
        let df = DateFormatter()
        df.locale = locale
        df.dateFormat = "dd\(separator)MMMM\(separator)yyyy"
        return df.string(from: date)
    }

    /// День и месяц в формате: 2 марта
    static func dayAndMonthShort(from date: Date, locale: Locale = ruLocale) -> String {
        let df = DateFormatter()
        df.locale = locale
        df.dateFormat = "d MMM"
        return String(df.string(from: date).dropLast())
    }

    /// Месяц в формате: Март
    static func month(from date: Date, locale: Locale = ruLocale) -> String {
        let df = DateFormatter()
        df.locale = locale
        df.dateFormat = "LLLL"
        return df.string(from: date).capitalized
    }

    /// Номер месяца в формате: 03
    static func monthNumber(from date: Date, locale: Locale = ruLocale) -> String {
        let df = DateFormatter()
        df.locale = locale
        df.dateFormat = "MM"
        return df.string(from: date)
    }

    /// День и месяц со временем в формате: 2 марта, 11:19
    static func dayMonthTime(from date: Date, locale: Locale = ruLocale) -> String {
        let df = DateFormatter()
        df.locale = locale
        df.dateFormat = "d MMMM, HH:mm"
        return df.string(from: date)
    }

    /// Год в формате: 2022
    static func year(from date: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy"
        return df.string(from: date)
    }
}
