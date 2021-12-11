//
//  Day.swift
//  Kalendae WatchKit Extension
//
//  Created by Kevin Guan on 6/28/20.
//  Copyright © 2020 Kevin Guan. All rights reserved.
//
import Foundation

struct Day: Identifiable {
    var id = UUID()
    var date: Date
    var year: Int = 0
    var month: Int = 0
    var day: Int = 0
    var isToday = false
    var sameMonth = false
}
