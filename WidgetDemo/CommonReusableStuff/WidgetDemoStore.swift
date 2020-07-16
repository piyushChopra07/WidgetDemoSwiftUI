//
//  WidgetDemoStore.swift
//  WidgetDemo
//
//  Created by Piyush Chopra on 12/07/20.
//

import Foundation

class WidgetDemoStore {
    static let shared: WidgetDemoStore = WidgetDemoStore()
    let userDefaults: UserDefaults

    private init() {
        guard let userDefaults = UserDefaults(suiteName: UserDefaultsSuiteName) else {
            fatalError("Could not instantiate shared user defaults.")
        }
        
        self.userDefaults = userDefaults
    }
    
    var selectedCountryName: String{
        get {
            return("\(userDefaults.value(forKey: "selectedCountryName") ?? "")")
        }
        set (newValue){
            userDefaults.set(newValue, forKey: "selectedCountryName")
        }
    }

}
