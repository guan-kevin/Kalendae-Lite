//
//  KalendaeView.swift
//  Kalendae Lite WatchKit Extension
//
//  Created by Kevin on 11/11/21.
//

import SwiftUI

struct KalendaeView: View {
    @StateObject var model = MonthViewModel()

    let appRefreshed = NotificationCenter.default.publisher(for: NSNotification.Name("userRefreshedApp"))
    let dayChanged = NotificationCenter.default.publisher(for: .NSCalendarDayChanged)

    var body: some View {
        NavigationView {
            MonthView(model: model)
                .onReceive(appRefreshed) { _ in
                    // update date
                    model.updateTodayDate()
                }
                .onReceive(dayChanged) { _ in
                    // update date
                    model.updateTodayDate()
                }
                .onAppear {
                    model.viewDidLoad()
                }
                .focusable(true)
                .digitalCrownRotation($model.crownSelected, from: 0, through: 36, by: 1, sensitivity: .low, isContinuous: true, isHapticFeedbackEnabled: true)
        }
        .navigationTitle(model.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct KalendaeView_Previews: PreviewProvider {
    static var previews: some View {
        KalendaeView()
    }
}
