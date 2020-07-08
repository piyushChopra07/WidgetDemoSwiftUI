//
//  CoronaStats.swift
//  CoronaStats
//
//  Created by Piyush Chopra on 06/07/20.
//

import WidgetKit
import SwiftUI

@main
struct CoronaStats: Widget {
    private let kind: String = "CoronaStats"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: StatsTimeline(), placeholder: PlaceholderView()) { entry in
            CoronaStatsEntryView(entry: entry)
        }
        .configurationDisplayName("Coronavirus Stats")
        .description("Shows the stats of the selected country.")
    }
}

struct PlaceholderView : View {
    var body: some View {
        Text("Loading...")
    }
}

struct CoronaStatsEntryView : View {
    let entry: CoronaStatsEntry
    var body: some View {
        let userDefaults = UserDefaults(suiteName: "group.com.piyushchopra.widgetdemo")

        if (userDefaults?.string(forKey: "selectedCountryName") ?? "") == "" {
            let viewToReturn = VStack(alignment: .leading, spacing: 4) {
                Text("Stats of selected country will show here.")
                    .font(.system(.title3))
                    .foregroundColor(.black)
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [.orange, .yellow]), startPoint: .top, endPoint: .bottom))
            return AnyView(viewToReturn)
        }else {
            let viewToReturn = VStack(alignment: .leading, spacing: 4) {
                Text("\(entry.commit.countryName)")
                    .font(.system(.title3))
                    .foregroundColor(.black)
                Text("Total cases: \(entry.commit.count)")
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


struct CountryStats {
    let count: Int64
    let countryName: String
    let date: String
}

struct CoronaStatsEntry: TimelineEntry {
    public let date: Date
    public let commit: CountryStats
    var relevance: TimelineEntryRelevance? {
        return TimelineEntryRelevance(score: 100) // 0 - not important | 100 - very important
    }
}

struct StatsTimeline: TimelineProvider {
    typealias Entry = CoronaStatsEntry
    let networkManager = NetworkManager()
    public func snapshot(with context: Context, completion: @escaping (Entry) -> ()) {
        let fakeCommit = CountryStats(count: 0, countryName: "N.A.", date: "")
        let entry = Entry(date: Date(), commit: fakeCommit)
        completion(entry)
    }

    func timeline(with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!

        let userDefaults = UserDefaults(suiteName: "group.com.piyushchopra.widgetdemo")

        guard let selectedCountryName = userDefaults?.string(forKey: "selectedCountryName") else {
            let  commit = CountryStats(count: 0, countryName: "N.A.", date: "")
            
            let entry = Entry(date: Date(), commit: commit)
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
            completion(timeline)
            return
        }
        
        
        let url = "https://api.covid19api.com/total/country/\(selectedCountryName.lowercased())/status/confirmed?from=2020-07-06T00:00:00Z&to=2020-08-06T00:00:00Z"
        
        networkManager.loadDataByAlamofire(url) { responseData in
            guard let rawArray = responseData["data"] as? [[String: Any]],
                  let lastUpdate = rawArray.last else {
                let  commit = CountryStats(count: 0, countryName: "N.A.", date: "")

                let entry = Entry(date: currentDate, commit: commit)
                let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
                completion(timeline)
                return
            }

            let count = lastUpdate["Cases"] as! Int64
            let countryName = lastUpdate["Country"] as! String
            let date = lastUpdate["Date"] as! String

            let commit: CountryStats = CountryStats(count: count, countryName: countryName, date: date)
            let entry = Entry(date: currentDate, commit: commit)
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
            completion(timeline)
        }
    }
}
