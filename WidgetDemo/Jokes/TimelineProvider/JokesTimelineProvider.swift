//
//  StatsTimeline.swift
//  WidgetDemo
//
//  Created by Piyush Chopra on 11/07/20.
//

import WidgetKit
import SwiftUI

struct JokesTimelineProvider: TimelineProvider {
    typealias Entry = JokesEntry
    
    let networkManager = NetworkManager()
    
    public func snapshot(with context: Context, completion: @escaping (Entry) -> ()) {
        let entry = JokesEntry(date: Date(), joke: "Ready to giggle?")
        completion(entry)
    }

    func timeline(with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 5, to: currentDate)!
        
        let url = "http://api.icndb.com/jokes/random/10/"
        
        networkManager.fetchData(url) { responseData in
            guard let rawArray = responseData["value"] as? [[String: Any]] else {
                let entry = JokesEntry(date: Date(), joke: "3")
                let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
                completion(timeline)
                return
            }
            
            let date = Date()
            let calendar = Calendar.current

            
            let entries = rawArray.enumerated().map { offset, currentJoke in
                JokesEntry(date: calendar.date(byAdding: .minute, value: 5, to: date)!,
                           joke: currentJoke["joke"] as? String ?? "4")
            }
            
            let timeline = Timeline(entries: entries, policy: .after(refreshDate))
            completion(timeline)
        }
    }
}
