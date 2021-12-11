//
//  CalendarManager.swift
//  Kalendae Lite WatchKit Extension
//
//  Created by Kevin on 11/11/21.
//

import EventKit
import Foundation

class CalendarManager {
    static let shared = CalendarManager()

    var store: EKEventStore
    var hasAccess = false

    private init() {
        store = EKEventStore()
    }

    func requestAccess() {
        store.requestAccess(to: .event) { granted, _ in
            if granted {
                self.hasAccess = true
            }
        }
    }

    func allEventsIn(year: Int, month: Int) -> [EKEvent] {
        guard hasAccess else { return [] }
        let start = Calendar.current.date(from: DateComponents(year: year, month: month))!
        let end = start.endOfMonth()
        let predicate = store.predicateForEvents(withStart: start, end: end, calendars: nil)

        return store.events(matching: predicate)
    }

    func allEventsIn(year: Int, month: Int, day: Int) -> [EKEvent] {
        guard hasAccess else { return [] }
        let start = Calendar.current.date(from: DateComponents(year: year, month: month, day: day))!
        let end = start.endOfDay()
        let predicate = store.predicateForEvents(withStart: start, end: end, calendars: nil)

        return store.events(matching: predicate)
    }
}
