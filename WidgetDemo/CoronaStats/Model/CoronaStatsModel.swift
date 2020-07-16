//
//  CountryStats.swift
//  WidgetDemo
//
//  Created by Piyush Chopra on 11/07/20.
//

import WidgetKit
import SwiftUI

struct CountryStats {
    let name: String
    let count: Int64
    let date: String
}

struct CoronaStatsTimelineEntry: TimelineEntry {
    public let date: Date
    public let data: CountryStats
    var relevance: TimelineEntryRelevance? {
        TimelineEntryRelevance(score: TimelineEntryRelevanceScoreHigh)
    }
}
