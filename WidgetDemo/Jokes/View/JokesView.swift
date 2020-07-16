//
//  View.swift
//  WidgetDemo
//
//  Created by Piyush Chopra on 12/07/20.
//

import SwiftUI
import WidgetKit

struct JokesEntryView : View {
    var entry: JokesTimelineProvider.Entry
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            VStack{
                Text(entry.joke)
                    .minimumScaleFactor(0.3)
                    .padding(.all, 5)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.green)
        default:
            VStack{
                
                Text("Chuck Norris Cracks:")
                    .font(.system(.headline, design: .rounded))
                    .padding()
                
                Text(entry.joke)
                    .minimumScaleFactor(0.3)
                    .padding(.all, 5)
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.pink)
        }
        
    }
}
