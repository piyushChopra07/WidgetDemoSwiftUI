//
//  Country.swift
//  WidgetDemo
//
//  Created by Piyush Chopra on 07/07/20.
//

import Foundation

struct Country: Decodable, Identifiable {
    var id = UUID()
    var name: String
}
