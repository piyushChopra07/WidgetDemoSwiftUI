//
//  ContentView.swift
//  WidgetDemo
//
//  Created by Piyush Chopra on 06/07/20.
//

import SwiftUI
import Foundation
import WidgetKit

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()

    @State var countries: [Country] = []
    @State var isLoading: Bool = false
    @State var selectedCountryName: String = ""
    var body: some View {
        NavigationView() {
            VStack {
                
                if isLoading {
                    Text("Loading ...")
                } else {
List(countries) { country in
    Button(action: {
        selectedCountryName = country.name
        let userDefaults = UserDefaults(suiteName: "group.com.piyushchopra.widgetdemo")
        userDefaults?.setValue(selectedCountryName, forKey: "selectedCountryName")
        userDefaults?.synchronize()
        WidgetCenter.shared.reloadAllTimelines()
    }) {
        HStack {
            Text(country.name)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                .padding()
                .background(selectedCountryName == country.name ? Color(UIColor(white: 0, alpha: 0.2)) : Color.white)

        }
    }
}
                }
            }
            .navigationBarTitle(Text("Select Country")).foregroundColor(.black)
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        let userDefaults = UserDefaults(suiteName: "group.com.piyushchopra.widgetdemo")

        selectedCountryName = userDefaults?.string(forKey: "selectedCountryName") ?? ""
        isLoading = true
        networkManager.loadDataByAlamofire("https://api.covid19api.com/countries") { responseData in
            
            guard let rawCountries = responseData["data"] as? [[String: Any]] else { return }

            var countries = [Country]()
            for rawCountry in rawCountries {
                let country = Country(name: rawCountry["Country"] as! String)
                countries.append(country)
            }
            countries.sort { country1, country2 -> Bool in
                country1.name < country2.name
            }

            self.countries = countries
            self.isLoading = false
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

