//
//  WidgetDemoBundle.swift
//  WidgetDemoBundle
//
//  Created by Piyush Chopra on 12/07/20.
//

import WidgetKit
import SwiftUI

struct CoronaStatsWidget: Widget {
    private let kind: String = "CoronaStatsWidget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: StatsTimelineProvider(), placeholder: PlaceholderView()) { entry in
            CoronaStatsEntryView(entry: entry)
        }
        .supportedFamilies(AllSupportedFamilies)
        .configurationDisplayName("Coronavirus Stats")
        .description("Shows the stats of the selected country.")
    }
}

struct JokesWidget: Widget {
    private let kind: String = "JokesWidget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: JokesTimelineProvider(), placeholder: PlaceholderView()) { entry in
            JokesEntryView(entry: entry)
        }
        .configurationDisplayName("Chuck Norris Jokes")
        .description("Shows random jokes.")
    }
}


@main
struct WidgetDemoBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        CoronaStatsWidget()
        JokesWidget()
    }
}
