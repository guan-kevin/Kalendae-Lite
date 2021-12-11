//
//  Date.swift
//  Kalendae WatchKit Extension
//
//  Created by Kevin Guan on 6/28/20.
//  Copyright © 2020 Kevin Guan. All rights reserved.
//

import Foundation

extension Date {
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self) - 1
    }

    var firstDayOfTheMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
    }

    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self)
    }

    func monthString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: self)
    }

    func fullMonthString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }

    func currentTime() -> Int {
        return Int(timeIntervalSince1970)
    }

    func getDateString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    func startOfMonth() -> (date: Date, weekday: Int) {
        let calendar = Calendar.current
        let date = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
        let weekday = calendar.component(.weekday, from: self)

        return (date, weekday)
    }

    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, second: -1), to: startOfMonth().date)!
    }

    func endOfDay() -> Date {
        return Calendar.current.date(byAdding: DateComponents(day: 1, second: -1), to: self)!
    }

    func daysPerMonth() -> Int {
        let calendar = Calendar.current
        return calendar.range(of: .day, in: .month, for: startOfMonth().date)?.count ?? 0
    }
}
