//
//  MonthView.swift
//  Kalendae Lite WatchKit Extension
//
//  Created by Kevin on 11/11/21.
//

import SwiftUI
import WatchKit

struct MonthView: View {
    var layout = Array(repeating: GridItem(.flexible()), count: 7)

    @ObservedObject var model: MonthViewModel
    @State var openDate: Day? = nil

    var body: some View {
        VStack {
            LazyVGrid(columns: layout, spacing: 0) {
                ForEach(0 ..< 7) { symbol in
                    HStack {
                        Text("\(self.model.weeks[symbol].label)")
                            .font(.system(size: 12))
                            .foregroundColor(.red)
                    }
                }
            }

            LazyVGrid(columns: layout, alignment: .center, spacing: 0) {
                ForEach(model.days) { day in
                    Text("\(day.day)")
                        .font(.system(size: Helper.font))
                        .lineLimit(1)
                        .frame(height: Helper.dayHeight)
                        .foregroundColor(day.isToday ? .red : day.sameMonth ? .white : .gray)
                        .onTapGesture {
                            openDate = day
                        }
                }
            }

            Spacer()
        }
        .sheet(item: $openDate) { day in
            DayView(day: day)
        }
    }
}

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MonthView(model: MonthViewModel())
                .previewDevice("Apple Watch Series 7 - 45mm")
            MonthView(model: MonthViewModel())
                .previewDevice("Apple Watch Series 7 - 41mm")
            MonthView(model: MonthViewModel())
                .previewDevice("Apple Watch Series 6 - 44mm")
            MonthView(model: MonthViewModel())
                .previewDevice("Apple Watch Series 6 - 40mm")
            MonthView(model: MonthViewModel())
                .previewDevice("Apple Watch Series 3 - 42mm")
            MonthView(model: MonthViewModel())
                .previewDevice("Apple Watch Series 3 - 38mm")
        }
    }
}
