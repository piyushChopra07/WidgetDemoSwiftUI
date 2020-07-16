//
//  View.swift
//  WidgetDemo
//
//  Created by Piyush Chopra on 12/07/20.
//

import SwiftUI
import WidgetKit

struct CoronaStatsEntryView : View {
    let entry: CoronaStatsTimelineEntry
    var body: some View {

        if WidgetDemoStore.shared.selectedCountryName == "" {
            let viewToReturn = VStack(alignment: .leading, spacing: 4) {
                Text("Stats of selected country will show here.")
                    .font(.system(.title3))
                    .foregroundColor(.black)
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [.orange, .yellow]), startPoint: .top, endPoint: .bottom))
            return AnyView(viewToReturn)
        } else {
            let viewToReturn = VStack(alignment: .leading, spacing: 4) {
                Text("\(entry.data.name)")
                    .font(.system(.title3))
                    .foregroundColor(.black)
                Text("Total cases: \(entry.data.count)")
                    .font(.system(.callout))
                    .foregroundColor(.black)
                    .bold()
                Text("Updated at \(Self.format(date:entry.date))")
                    .font(.system(.caption2))
                    .foregroundColor(.black)
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [.orange, .yellow]), startPoint: .top, endPoint: .bottom))
            return AnyView(viewToReturn)
        }
    }
    static func format(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        return formatter.string(from: date)
    }
}
