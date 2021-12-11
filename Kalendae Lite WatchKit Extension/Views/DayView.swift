//
//  DayView.swift
//  Kalendae Lite WatchKit Extension
//
//  Created by Kevin on 11/11/21.
//

import EventKit
import SwiftUI

struct DayView: View {
    @Environment(\.dismiss) var dismiss
    let day: Day
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()

    @State var events: [EKEvent] = []
    @State var loaded = false

    var body: some View {
        NavigationView {
            Group {
                if loaded {
                    eventsView
                } else {
                    ProgressView()
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        dismiss()
                    }) {
                        Label(dateFormatter.string(from: day.date), systemImage: "chevron.backward")
                            .foregroundColor(.accentColor)
                    }
                }
            })
        }
        .onAppear {
            DispatchQueue.main.async {
                self.events = CalendarManager.shared.allEventsIn(year: day.year, month: day.month, day: day.day).sorted { $0.compareStartDate(with: $1) == .orderedAscending }
                self.loaded = true
            }
        }
    }

    var eventsView: some View {
        Group {
            if events.count == 0 {
                VStack {
                    Image(systemName: "calendar")
                        .font(.largeTitle)
                    Text("No Events")
                }
            } else {
                List {
                    ForEach(events, id: \.eventIdentifier) { event in
                        NavigationLink(destination: EventView(event: event)) {
                            HStack(alignment: .center, spacing: 5) {
                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(Color(event.calendar.cgColor))

                                VStack(alignment: .leading) {
                                    Text(event.title)

                                    if event.isAllDay {
                                        Text("All-day")
                                            .font(.footnote)
                                    } else {
                                        Text(event.startDate, format: .dateTime)
                                            .font(.footnote)
                                        Text(event.endDate, format: .dateTime)
                                            .font(.footnote)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
