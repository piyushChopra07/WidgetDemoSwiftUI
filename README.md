# WidgetDemo Using SwiftUI

WidgetDemo is a SwiftUI Project for showcasing the basic usage of the iOS 14 Widgets developed with Swift UI.

It uses Apple's Swift Package Manager as a dependency manager in place of the widely used open-source Cocoapods.


To reflect the real-time changes of the app in the widget, see ContentView.swift

```swift
WidgetCenter.shared.reloadAllTimelines()
```

## **What's new**
Earlier we had one widget extension, CoronaStats. 
Now, to showcase adding multiple widgets in an application, either we can add multiple targets like we did in the app and manage the files per target, managing the common code to be available in all the targets without managing the [code redundancy.](https://en.wikipedia.org/wiki/Redundant_code)
Or we can use [Widget Bundles](https://developer.apple.com/documentation/swiftui/widgetbundle) introduced in iOS 14.

To do so, you need to remove the @main declaration of your main Widget's configuration and instead add it to a new bundle struct:

```swift
@main
struct WidgetDemoBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        CoronaStatsWidget()
        JokesWidget()
    }
}
```

Using Widget Bundles, we can add as many widgets to our project as we want without creating new targets per widget.

## **Basic overview**
- Added support of multiple widgets using [WidgetBundle](https://developer.apple.com/documentation/swiftui/widgetbundle)
     - Load the countries from [this Public API](https://api.covid19api.com/countries).
    - Display countries in a list
    - Save the selected country in shared user defaults
    - Reload Widget

- The app provide two widgets now: 
- **CoronaStats**
    - Load the statistics of coronavirus from [this Public API](https://api.covid19api.com/total/country/india/status/confirmed?from=2020-07-06T00:00:00Z&to=2020-08-06T00:00:00Z").
    - The widget refresh rate is set to 1 hour.
```swift
let refreshDate = Calendar.current.date(byAdding: .hour, value: 1, to: Date())!
```

- **Random Jokes**
    - Load the random jokes from [this Public API](http://api.icndb.com/jokes/random/10/).
    - Showcase how to create different views for different sized widget, depending on the [Widget Family](https://developer.apple.com/documentation/widgetkit/widgetfamily)
    - The widget refresh rate is set to 1 hour.
```swift
let refreshDate = Calendar.current.date(byAdding: .minute, value: 5, to: Date())!
```

P.S. this is just a demo widget. It is not much tested in the context of battery usage, so keep the app/widget on your device on your own risk. 

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.


## License
[MIT](https://choosealicense.com/licenses/mit/)
