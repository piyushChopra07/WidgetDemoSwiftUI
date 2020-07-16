//
//  WidgetExtensionConstants.swift
//  WidgetDemo
//
//  Created by Piyush Chopra on 11/07/20.
//

import Foundation
import WidgetKit

/**
 The timeline entry relevence score can vary from 0 to 100, where 0 means unimportant, and 100 means important.
 We are using 100 as the demo shows the Coronavirus stats for the selected country, and we want to show the latest information to the user everytime.
 */
let TimelineEntryRelevanceScoreHigh: Float = 100
let TimelineEntryRelevanceScoreMedium: Float = 50

/**
 There are 3 sizes supported iOS 14 onwards.
 Small, Medium and Large.
 */
let AllSupportedFamilies: [WidgetFamily] = [.systemSmall, .systemMedium, .systemLarge]

let AllSupportedFamiliesExceptSmall: [WidgetFamily] = [.systemSmall, .systemMedium, .systemLarge]
