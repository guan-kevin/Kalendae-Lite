//
//  Helper.swift
//  Kalendae Lite WatchKit Extension
//
//  Created by Kevin on 11/11/21.
//

import Foundation
import WatchKit

class Helper {
    static var font: CGFloat = {
        switch WKInterfaceDevice.current().screenBounds.size.width {
        case 136:
            return 12
        case 156:
            return 14
        default:
            return 16
        }
    }()

    static var isDeprecated: Bool = {
        font < 16
    }()

    static var dayHeight: CGFloat = {
        WKInterfaceDevice.current().screenBounds.size.width / (Helper.isDeprecated ? 7 : 8)
    }()
}
