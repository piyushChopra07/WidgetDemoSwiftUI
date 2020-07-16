//
//  StatsTimeline.swift
//  WidgetDemo
//
//  Created by Piyush Chopra on 11/07/20.
//

import WidgetKit
import SwiftUI

struct StatsTimelineProvider: TimelineProvider {
    typealias Entry = CoronaStatsTimelineEntry
    
    let networkManager = NetworkManager()
    
    public func snapshot(with context: Context, completion: @escaping (Entry) -> ()) {
        let dummySnapshot = CountryStats(name: "N.A.", count: 0, date: "")
        let entry = Entry(date: Date(), data: dummySnapshot)
        completion(entry)
    }

    func timeline(with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!

        let selectedCountryName = WidgetDemoStore.shared.selectedCountryName
        
        if  selectedCountryName == "" {
            let  commit = CountryStats(name: "N.A.", count: 0, date: "")
            
            let entry = Entry(date: Date(), data: commit)
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
            completion(timeline)
            return
        }
        
        let url = "https://api.covid19api.com/total/country/\(selectedCountryName.lowercased())/status/confirmed?from=2020-07-06T00:00:00Z&to=2020-08-06T00:00:00Z"
        
        networkManager.fetchData(url) { responseData in
            guard let rawArray = responseData["data"] as? [[String: Any]],
                  let lastUpdate = rawArray.last else {
                let  commit = CountryStats(name: "N.A.", count: 0, date: "")

                let entry = Entry(date: currentDate, data: commit)
                let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
                completion(timeline)
                return
            }

            let count = lastUpdate["Cases"] as! Int64
            let date = lastUpdate["Date"] as! String

            let commit: CountryStats = CountryStats(name: selectedCountryName, count: count, date: date)
            let entry = Entry(date: currentDate, data: commit)
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
            completion(timeline)
        }
    }
}
