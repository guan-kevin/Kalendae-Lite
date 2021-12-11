//
//  MonthViewModel.swift
//  Kalendae WatchKit Extension
//
//  Created by Kevin Guan on 6/28/20.
//  Copyright © 2020 Kevin Guan. All rights reserved.
//

import Foundation
import SwiftUI

class MonthViewModel: ObservableObject {
    var inited = false

    var startWeekOn = UserDefaults.standard.integer(forKey: "startWeekOn") // 0: Sunday, 1: Monday, 2: Tuesday, 3: Wednesday, 4: Thursday, 5: Friday, 6: Saturday

    var selectedMonth: Int!
    var selectedYear: Int!

    var todayMonth: Int!
    var todayYear: Int!
    var todayDay: Int!

    @Published var weeks: [Week] = [Week(label: "S"), Week(label: "M"), Week(label: "T"), Week(label: "W"), Week(label: "T"), Week(label: "F"), Week(label: "S")]
    @Published var title = ""
    @Published var days: [Day] = []

    @Published var crownSelected = 0.0 {
        didSet {
            guard inited else { return }

            if Int(crownSelected/3) + 1 != selectedMonth {
                // switch month
                let currentSelectedMonth = Int(crownSelected/3) + 1

                if currentSelectedMonth == 1, selectedMonth == 12 {
                    // next year
                    selectedYear += 1
                } else if currentSelectedMonth == 12, selectedMonth == 1 {
                    // previous year
                    selectedYear -= 1
                }

                guard currentSelectedMonth >= 1, currentSelectedMonth <= 12 else { return }
                selectedMonth = currentSelectedMonth

                setUpLabel(year: selectedYear, month: selectedMonth)
            }
        }
    }

    func viewDidLoad() {
        if !inited {
            let dates = Date()
            let calendar = Calendar.current
            selectedYear = calendar.component(.year, from: dates)
            selectedMonth = calendar.component(.month, from: dates)

            todayYear = selectedYear
            todayMonth = selectedMonth
            todayDay = calendar.component(.day, from: dates)

            crownSelected = Double(todayMonth - 1) * 3 + 1

            setUpLabel(year: selectedYear, month: selectedMonth)

            setUpWeekLabel()
        }

        inited = true
    }

    func updateTodayDate() {
        let dates = Date()
        let calendar = Calendar.current

        todayYear = calendar.component(.year, from: dates)
        todayMonth = calendar.component(.month, from: dates)
        todayDay = calendar.component(.day, from: dates)
    }

    func setUpWeekLabel() {
        switch startWeekOn {
        case 1:
            weeks = [Week(label: "M"), Week(label: "T"), Week(label: "W"), Week(label: "T"), Week(label: "F"), Week(label: "S"), Week(label: "S")]
        case 2:
            weeks = [Week(label: "T"), Week(label: "W"), Week(label: "T"), Week(label: "F"), Week(label: "S"), Week(label: "S"), Week(label: "M")]
        case 3:
            weeks = [Week(label: "W"), Week(label: "T"), Week(label: "F"), Week(label: "S"), Week(label: "S"), Week(label: "M"), Week(label: "T")]
        case 4:
            weeks = [Week(label: "T"), Week(label: "F"), Week(label: "S"), Week(label: "S"), Week(label: "M"), Week(label: "T"), Week(label: "W")]
        case 5:
            weeks = [Week(label: "F"), Week(label: "S"), Week(label: "S"), Week(label: "M"), Week(label: "T"), Week(label: "W"), Week(label: "T")]
        case 6:
            weeks = [Week(label: "S"), Week(label: "S"), Week(label: "M"), Week(label: "T"), Week(label: "W"), Week(label: "T"), Week(label: "F")]
        default:
            weeks = [Week(label: "S"), Week(label: "M"), Week(label: "T"), Week(label: "W"), Week(label: "T"), Week(label: "F"), Week(label: "S")]
        }
    }

    func setUpLabel(year: Int, month: Int) {
        let calendar = Calendar.current
        let date = calendar.date(from: DateComponents(year: year, month: month))!
        var temp: [Day] = []

        let start = date.startOfMonth()
        let count = date.daysPerMonth()

        if year == todayYear, month == todayMonth {
            for i in -start.weekday + 1 ..< -start.weekday + 43 {
                let date = calendar.date(byAdding: .day, value: i, to: start.date)!
                let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
                temp.append(Day(date: date, year: components.year ?? 0, month: components.month ?? 0, day: components.day ?? 0, isToday: components.day == todayDay && components.month == todayMonth, sameMonth: i >= 0 && i < count))
            }
        } else {
            for i in -start.weekday + 1 ..< -start.weekday + 43 {
                let date = calendar.date(byAdding: .day, value: i, to: start.date)!
                let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
                temp.append(Day(date: date, year: components.year ?? 0, month: components.month ?? 0, day: components.day ?? 0, isToday: false, sameMonth: i >= 0 && i < count))
            }
        }

        title = calendar.monthSymbols[selectedMonth - 1] + " " + String(selectedYear % 100)
        days = temp
    }
}
