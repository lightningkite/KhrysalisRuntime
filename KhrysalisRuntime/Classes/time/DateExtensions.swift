//
//  DateExtensions.swift
//  KhrysalisRuntime
//
//  Created by Joseph Ivie on 11/6/21.
//

import Foundation

private let eraBasis = DateComponents(era: 1, year: 1970, month: 1, day: 1, hour: 0, minute: 0, second: 0, nanosecond: 0)

public protocol HasDateComponents: Comparable {
    var dateComponents: DateComponents { get set }
}
extension DateComponents: HasDateComponents {
    public var dateComponents: DateComponents { get { self } set { self = newValue }}
}
public extension HasDateComponents {
    static func < (lhs: Self, rhs: Self) -> Bool {
        let left = (lhs.dateComponents.calendar ?? Calendar.current).date(from: lhs.dateComponents)!
        let right = (rhs.dateComponents.calendar ?? Calendar.current).date(from: rhs.dateComponents)!
        return left < right
    }
    func format(_ formatter: DateFormatter) -> String {
        let cal = dateComponents.calendar ?? Calendar.current
        if let date = cal.date(from: self.dateComponents) {
            return formatter.string(from: date)
        } else {
            return "-"
        }
    }
}
private extension HasDateComponents {
    mutating func absorb(other: DateComponents) {
        self.dateComponents = DateComponents(
            calendar: other.calendar ?? self.dateComponents.calendar,
            timeZone: other.timeZone ?? self.dateComponents.timeZone,
            era: other.era ?? self.dateComponents.era,
            year: other.year ?? self.dateComponents.year,
            month: other.month ?? self.dateComponents.month,
            day: other.day ?? self.dateComponents.day,
            hour: other.hour ?? self.dateComponents.hour,
            minute: other.minute ?? self.dateComponents.minute,
            second: other.second ?? self.dateComponents.second,
            nanosecond: other.nanosecond ?? self.dateComponents.nanosecond
        )
    }
}

public struct LocalDate: HasDateComponents {
    public var dateComponents: DateComponents
    public var calendar: Calendar { get { dateComponents.calendar! } set { dateComponents.calendar = newValue } }
    public var era: Int { get { dateComponents.era! } set { dateComponents.era = newValue } }
    public var year: Int { get { dateComponents.year! } set { dateComponents.year = newValue } }
    public var month: Int { get { dateComponents.month! } set { dateComponents.month = newValue } }
    public var day: Int { get { dateComponents.day! } set { dateComponents.day = newValue } }
    public var epochDay: Int { get { Calendar.current.dateComponents([.day], from: Calendar.current.date(from: eraBasis)!, to: Calendar.current.date(from: self.dateComponents)!).day! } }
    public init(
        calendar: Calendar = Calendar.current,
        from: Date = Date()
    ) {
        dateComponents = calendar.dateComponents([.era, .year, .month, .day], from: from)
        self.calendar = calendar
    }
    public init(
        calendar: Calendar = Calendar.current,
        era: Int = 1,
        year: Int,
        month: Int,
        day: Int
    ) {
        dateComponents = DateComponents(calendar: calendar, era: era, year: year, month: month, day: day)
    }
    public init(calendar: Calendar = Calendar.current, epochDay: Int) {
        dateComponents = DateComponents(calendar: calendar, year: 1970, month: 1, day: epochDay + 1)
    }
    public func with(
        calendar: Calendar? = nil,
        era: Int? = nil,
        year: Int? = nil,
        month: Int? = nil,
        day: Int? = nil
    ) -> Self {
        Self(
            calendar: calendar ?? self.calendar,
            era: era ?? self.era,
            year: year ?? self.year,
            month: month ?? self.month,
            day: day ?? self.day
        )
    }
    public func plus(
        calendar: Calendar? = nil,
        era: Int = 0,
        year: Int = 0,
        month: Int = 0,
        day: Int = 0
    ) -> Self {
        Self(
            calendar: self.calendar,
            era: self.era + era,
            year: self.year + year,
            month: self.month + month,
            day: self.day + day
        )
    }
    
}
public struct LocalTime: HasDateComponents {
    public var dateComponents: DateComponents
    public var calendar: Calendar { get { dateComponents.calendar! } set { dateComponents.calendar = newValue } }
    public var hour: Int { get { dateComponents.hour! } set { dateComponents.hour = newValue } }
    public var minute: Int { get { dateComponents.minute! } set { dateComponents.minute = newValue } }
    public var second: Int { get { dateComponents.second! } set { dateComponents.second = newValue } }
    public var nanosecond: Int { get { dateComponents.nanosecond! } set { dateComponents.nanosecond = newValue } }
    public init(
        calendar: Calendar = Calendar.current,
        from: Date = Date()
    ) {
        dateComponents = calendar.dateComponents([.hour, .minute, .second, .nanosecond], from: from)
        self.calendar = calendar
    }
    public init(
        calendar: Calendar = Calendar.current,
        hour: Int,
        minute: Int = 0,
        second: Int = 0,
        nanosecond: Int = 0
    ) {
        dateComponents = DateComponents(calendar: calendar, hour: hour, minute: minute, second: second, nanosecond: nanosecond)
    }
    public func with(
        calendar: Calendar? = nil,
        hour: Int? = nil,
        minute: Int? = nil,
        second: Int? = nil,
        nanosecond: Int? = nil
    ) -> Self {
        Self(
            calendar: calendar ?? self.calendar,
            hour: hour ?? self.hour,
            minute: minute ?? self.minute,
            second: second ?? self.second,
            nanosecond: nanosecond ?? self.nanosecond
        )
    }
    public func plus(
        hour: Int = 0,
        minute: Int = 0,
        second: Int = 0,
        nanosecond: Int = 0
    ) -> Self {
        Self(
            calendar: self.calendar,
            hour: self.hour + hour,
            minute: self.minute + minute,
            second: self.second + second,
            nanosecond: self.nanosecond + nanosecond
        )
    }
    
    public static let MIN = LocalTime(hour: 0, minute: 0, second: 0, nanosecond: 0)
    public static let MAX = LocalTime(hour: 23, minute: 59, second: 59, nanosecond: 999_999_999)
}
public struct LocalDateTime: HasDateComponents {
    public var dateComponents: DateComponents
    public var calendar: Calendar { get { dateComponents.calendar! } set { dateComponents.calendar = newValue } }
    public var era: Int { get { dateComponents.era! } set { dateComponents.era = newValue } }
    public var year: Int { get { dateComponents.year! } set { dateComponents.year = newValue } }
    public var month: Int { get { dateComponents.month! } set { dateComponents.month = newValue } }
    public var day: Int { get { dateComponents.day! } set { dateComponents.day = newValue } }
    public var hour: Int { get { dateComponents.hour! } set { dateComponents.hour = newValue } }
    public var minute: Int { get { dateComponents.minute! } set { dateComponents.minute = newValue } }
    public var second: Int { get { dateComponents.second! } set { dateComponents.second = newValue } }
    public var nanosecond: Int { get { dateComponents.nanosecond! } set { dateComponents.nanosecond = newValue } }
    public init(
        calendar: Calendar = Calendar.current,
        from: Date = Date()
    ) {
        dateComponents = calendar.dateComponents([.era, .year, .month, .day, .hour, .minute, .second, .nanosecond], from: from)
        self.calendar = calendar
    }
    public init(
        calendar: Calendar = Calendar.current,
        era: Int = 1,
        year: Int,
        month: Int,
        day: Int = 0,
        hour: Int = 0,
        minute: Int = 0,
        second: Int = 0,
        nanosecond: Int = 0
    ) {
        dateComponents = DateComponents(calendar: calendar, year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond)
    }
    public init(
        localDate: LocalDate,
        localTime: LocalTime
    ) {
        dateComponents = localDate.dateComponents
        absorb(other: localTime.dateComponents)
    }
    func toLocalDate() -> LocalDate { LocalDate(calendar: calendar, era: era, year: year, month: month, day: day) }
    func toLocalTime() -> LocalTime { LocalTime(calendar: calendar, hour: hour, minute: minute, second: second, nanosecond: nanosecond) }
    public func with(
        calendar: Calendar? = nil,
        era: Int? = nil,
        year: Int? = nil,
        month: Int? = nil,
        day: Int? = nil,
        hour: Int? = nil,
        minute: Int? = nil,
        second: Int? = nil,
        nanosecond: Int? = nil
    ) -> Self {
        Self(
            calendar: calendar ?? self.calendar,
            era: era ?? self.era,
            year: year ?? self.year,
            month: month ?? self.month,
            day: day ?? self.day,
            hour: hour ?? self.hour,
            minute: minute ?? self.minute,
            second: second ?? self.second,
            nanosecond: nanosecond ?? self.nanosecond
        )
    }
    public func plus(
        era: Int = 0,
        year: Int = 0,
        month: Int = 0,
        day: Int = 0,
        hour: Int = 0,
        minute: Int = 0,
        second: Int = 0,
        nanosecond: Int = 0
    ) -> Self {
        Self(
            calendar: self.calendar,
            era: self.era + era,
            year: self.year + year,
            month: self.month + month,
            day: self.day + day,
            hour: self.hour + hour,
            minute: self.minute + minute,
            second: self.second + second,
            nanosecond: self.nanosecond + nanosecond
        )
    }
}
public struct ZonedDateTime: HasDateComponents {
    public var dateComponents: DateComponents
    public var calendar: Calendar { get { dateComponents.calendar! } set { dateComponents.calendar = newValue } }
    public var timeZone: TimeZone { get { dateComponents.timeZone! } set { dateComponents.timeZone = newValue } }
    public var era: Int { get { dateComponents.era! } set { dateComponents.era = newValue } }
    public var year: Int { get { dateComponents.year! } set { dateComponents.year = newValue } }
    public var month: Int { get { dateComponents.month! } set { dateComponents.month = newValue } }
    public var day: Int { get { dateComponents.day! } set { dateComponents.day = newValue } }
    public var hour: Int { get { dateComponents.hour! } set { dateComponents.hour = newValue } }
    public var minute: Int { get { dateComponents.minute! } set { dateComponents.minute = newValue } }
    public var second: Int { get { dateComponents.second! } set { dateComponents.second = newValue } }
    public var nanosecond: Int { get { dateComponents.nanosecond! } set { dateComponents.nanosecond = newValue } }
    public init(
        calendar: Calendar = Calendar.current,
        timeZone: TimeZone? = nil,
        from: Date = Date()
    ) {
        dateComponents = calendar.dateComponents([.era, .year, .month, .day, .hour, .minute, .second, .nanosecond], from: from)
        self.timeZone = timeZone ?? calendar.timeZone
        self.calendar = calendar
    }
    public init(
        calendar: Calendar = Calendar.current,
        timeZone: TimeZone = Calendar.current.timeZone,
        era: Int = 1,
        year: Int,
        month: Int,
        day: Int,
        hour: Int = 0,
        minute: Int = 0,
        second: Int = 0,
        nanosecond: Int = 0
    ) {
        dateComponents = DateComponents(calendar: calendar, timeZone: timeZone, era: era, year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond)
    }
    public init(
        calendar: Calendar = Calendar.current,
        timeZone: TimeZone = Calendar.current.timeZone,
        localDateTime: LocalDateTime
    ) {
        dateComponents = DateComponents(calendar: calendar, timeZone: timeZone)
        absorb(other: localDateTime.dateComponents)
    }
    public init(
        calendar: Calendar = Calendar.current,
        timeZone: TimeZone = Calendar.current.timeZone,
        localDate: LocalDate,
        localTime: LocalTime
    ) {
        dateComponents = DateComponents(calendar: calendar, timeZone: timeZone)
        absorb(other: localDate.dateComponents)
        absorb(other: localTime.dateComponents)
    }
    public func toLocalDate() -> LocalDate { LocalDate(calendar: calendar, year: year, month: month, day: day) }
    public func toLocalTime() -> LocalTime { LocalTime(calendar: calendar, hour: hour, minute: minute, second: second, nanosecond: nanosecond) }
    public func toLocalDateTime() -> LocalDateTime { LocalDateTime(calendar: calendar, year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond) }
    public func toDate() -> Date {
        return self.calendar.date(from: self.dateComponents)!
    }
    public func with(
        calendar: Calendar? = nil,
        timeZone: TimeZone? = nil,
        era: Int? = nil,
        year: Int? = nil,
        month: Int? = nil,
        day: Int? = nil,
        hour: Int? = nil,
        minute: Int? = nil,
        second: Int? = nil,
        nanosecond: Int? = nil
    ) -> Self {
        Self(
            calendar: calendar ?? self.calendar,
            timeZone: timeZone ?? calendar?.timeZone ?? self.timeZone,
            era: era ?? self.era,
            year: year ?? self.year,
            month: month ?? self.month,
            day: day ?? self.day,
            hour: hour ?? self.hour,
            minute: minute ?? self.minute,
            second: second ?? self.second,
            nanosecond: nanosecond ?? self.nanosecond
        )
    }
    public func plus(
        era: Int = 0,
        year: Int = 0,
        month: Int = 0,
        day: Int = 0,
        hour: Int = 0,
        minute: Int = 0,
        second: Int = 0,
        nanosecond: Int = 0
    ) -> Self {
        Self(
            calendar: self.calendar,
            timeZone: self.timeZone,
            era: self.era + era,
            year: self.year + year,
            month: self.month + month,
            day: self.day + day,
            hour: self.hour + hour,
            minute: self.minute + minute,
            second: self.second + second,
            nanosecond: self.nanosecond + nanosecond
        )
    }
}

public extension Date {
    func atZone(_ timeZone: TimeZone = TimeZone.current) -> ZonedDateTime {
        return ZonedDateTime(timeZone: timeZone, from: self)
    }
}

public extension DateFormatter {
    convenience init(dateStyle: DateFormatter.Style = .none, timeStyle: DateFormatter.Style = .none) {
        self.init()
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
        self.locale = Locale.current
    }
}
