//
//  EventView.swift
//  Kalendae Lite WatchKit Extension
//
//  Created by Kevin on 11/11/21.
//

import EventKit
import SwiftUI

struct EventView: View {
    let event: EKEvent
    @State var showAllDay = true
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text(event.title)
                        .font(.headline)
                    Spacer()
                }

                Text(event.calendar.title)
                    .foregroundColor(Color(event.calendar.cgColor))
                    .font(.footnote)

                if event.isAllDay, showAllDay {
                    Text("All-day event")
                        .onTapGesture {
                            showAllDay.toggle()
                        }
                } else {
                    VStack(alignment: .leading) {
                        Text("Start: ")
                        Text(event.startDate, format: .dateTime)
                            .font(.footnote)
                        Text("End: ")
                        Text(event.endDate, format: .dateTime)
                            .font(.footnote)
                    }
                    .onTapGesture {
                        showAllDay.toggle()
                    }
                }

                if event.hasNotes {
                    Text("Notes:")
                    Text(event.notes ?? "")
                        .font(.footnote)
                }
            }
        }
    }
}
