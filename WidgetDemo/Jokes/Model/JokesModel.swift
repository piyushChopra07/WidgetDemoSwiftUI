//
//  CountryStats.swift
//  WidgetDemo
//
//  Created by Piyush Chopra on 11/07/20.
//

import WidgetKit
import SwiftUI

struct ChuckJokes : Decodable {
    
    let type : String?
    let value : [ChuckValue]?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case value = "value"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        value = try values.decodeIfPresent([ChuckValue].self, forKey: .value)
    }
    
}

struct ChuckValue : Decodable {
    
    let id : Int?
    let joke : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case joke = "joke"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        joke = try values.decodeIfPresent(String.self, forKey: .joke)
    }
}


struct JokesEntry: TimelineEntry {
    public let date: Date
    public let joke : String
}
