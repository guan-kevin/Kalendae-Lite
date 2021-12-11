//
//  Kalendae_LiteApp.swift
//  Kalendae Lite WatchKit Extension
//
//  Created by Kevin on 11/11/21.
//

import SwiftUI

@main
struct Kalendae_LiteApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .onAppear {
                        CalendarManager.shared.requestAccess()
                    }
            }
        }
    }
}
