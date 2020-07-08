# WidgetDemo Using SwiftUI

- Load the countries from [the Public API](https://api.covid19api.com/countries).
- Display countries in a list
- Save the selected country in shared user defaults
- Reload Widget


WidgetDemo is a SwiftUI Project for showcasing the basic usage of the iOS 14 Widgets developed with Swift UI.

It uses Apple's Swift Package Manager as a dependency manager in place of the widely used open-source Cocoapods.


To reflect the real-time changes of the app in the widget, see ContentView.swift

```swift
WidgetCenter.shared.reloadAllTimelines()
```

The refresh rate is set to 1 hour.
```swift
let refreshDate = Calendar.current.date(byAdding: .hour, value: 1, to: Date())!
```

P.S. this is just a demo widget. It is not much tested in the context of battery usage, so keep the app/widget on your device on your own risk. 

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.


## License
[MIT](https://choosealicense.com/licenses/mit/)
