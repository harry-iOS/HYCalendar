# HYCalendar

- A customizable calander component written in Swift 3.

# Introduction:
HYCalendar is a custom calendar library. It includes following features:

- Can select date range
- Can select single date
- Left to Right and Right to left support
- Fully customizable UI
- Simple collection view to render dates
- No Xib

# Installation:
  # Using pods 
  ```swift 
  pod 'HYCalendar', :git => 'https://github.com/harry-iOS/HYCalendar.git'
  ```

  # Manually
  ```swift
  Simply drag and drop the CalenderView folder into your project.
  ```

# Requirements:
```swift
Xcode 8.3
Swift 3.0
```

# Usages:
  # Basic configuration
```swift
let calendar = CalendarView.init(frame: view.bounds)
calendar.calendarUIOptions = [.selectedDateCircleColor(UIColor.red)]
view.addsubView(calenderView)
```
- Available options

```swift
  public enum CalenderUIOptions {
    case collectionViewBackgroundColor(UIColor)
    case selectedDateCircleColor(UIColor)
    case selectedDateColor(UIColor)
    case headerBackgroundColor(UIColor)
    case headerCellTextColor(UIColor)
    case disabledDateColor(UIColor)
    case dateDefaultColor(UIColor)
    case headerViewTitleColor(UIColor)
    case headerCellTextFont(UIFont)
    case dateFont(UIFont)
    case headerViewTitleFont(UIFont)
}
```

# For RTL and LTR support
```swift
calendar.isRTL = false // default is false
```

# Enable the specific date range
```swift
calendar.dateRange = (startDate:Date,endDate:Date)?
```

# Single date selection
```swift
calendar.canCheckSingleDate = true/false // to select the single date. Default value is false
```

# Render data
```swift
let fromMonth = Date.init().getMonthFromDateForCalendar()
let fromYear = Date.init().getYearFromDateForCalendar()
let toMonth = Date.init().addDateComponentsInDate(0, monthsToAdd:40).getMonthFromDateForCalendar()
let toYear = Date.init().addDateComponentsInDate(0, monthsToAdd:40).getYearFromDateForCalendar()
start = Date().addDateComponentsInDate(1)
end = Date().addDateComponentsInDate(4)
calendar.renderData(fromMonth, fromYear: fromYear, toMonth:toMonth , toYear: toYear, startDate: start, endDate:end)
```

For more usages check out the attached sample.

# License:
This project is licensed under the terms of the MIT license
