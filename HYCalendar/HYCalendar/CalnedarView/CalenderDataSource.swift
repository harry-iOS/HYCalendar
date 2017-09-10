//  CalenderDataSource.swift
//  CalendarPOC
//
//  Created by Harry on 03/05/16.
//  Copyright © 2016 TTND. All rights reserved.
//

import UIKit

class CalenderDataSource : NSObject {

    func getDataSourceForCalendar(_ fromMonth:Int,fromYear:Int,toMonth:Int,toYear:Int, completionClosure : ([AnyObject]) -> Void) {
        assert(fromYear < toYear, "!!!!!!!!!!!!=========Start date is less than to end date.===========!!!!!!!!!!")
        if fromYear == toYear {
            assert(fromMonth > toMonth,"!!!!!!!!!!!!=========Start date is less than to end date.===========!!!!!!!!!!")
        }
        let array = getDataSourceArray(fromMonth, fromYear: fromYear, toMonth: toMonth, toYear: toYear)
        completionClosure(array)
    }

    fileprivate func getDataSourceArray(_ fromMonth: Int, fromYear: Int, toMonth: Int, toYear: Int) -> [AnyObject] {
        let numberOfMonths = getNumberOfMonths(fromMonth, fromYear: fromYear, toMonth: toMonth, toYear: toYear)
        var array = [AnyObject]()
        var year = fromYear
        var startMonth = fromMonth
        for index in 0..<numberOfMonths {
            let monthsArray = getMonthsArray(startMonth, year:year)
            array.append(monthsArray as AnyObject)
            startMonth += 1
            if (index + fromMonth)%12 == 0 {
                year += 1
                startMonth = 1
            }
        }
        return array
    }

    fileprivate func getNumberOfMonths(_ fromMonth:Int,fromYear:Int,toMonth:Int,toYear:Int) -> Int {
        var numberOfMonths = 0
        if fromYear == toYear {
            numberOfMonths = toMonth - fromMonth
        } else if fromYear < toYear {
            numberOfMonths = (12 - fromMonth) + toMonth + 12 * (toYear - fromYear - 1)
        }
        numberOfMonths += 1 // Because boths months are inclusive
        return numberOfMonths
    }

    // Mark : Return Date formatter
    fileprivate func dateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }

    fileprivate func numberOfDaysInMonth(_ monthNumber:Int, date:Date) -> Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        var components = DateComponents()
        components.month = monthNumber
        let range = (calendar as NSCalendar).range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: date)
        return range.length
    }

    fileprivate func weekDayForDate(_ date:Date) -> Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        let components = (calendar as NSCalendar).components(NSCalendar.Unit.weekday, from: date)
        return components.weekday!
    }

    fileprivate func getMonthsArray(_ month: Int, year: Int) -> [AnyObject] {
        var array = [Date]()
        let date = dateFormatter().date(from: "1/\(month)/\(year)")
        let numberOfDays = numberOfDaysInMonth(month, date:date!)
        let index = weekDayForDate(date!)
        var value = 1
        while (value < index + numberOfDays) {
            var date : Date?
            if value < index {
                date = Date(timeIntervalSince1970: 0)
            } else {
                let difference = value - index + 1
                date = dateFormatter().date(from: "\(difference)/\(month)/\(year)")
            }
            array.append(date!)
            value += 1
        }
        return array as [AnyObject]
    }

    class func convertDateToString(_ date:Date) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd/MM/yyyy"
        let string = formatter.string(from: date)
        print(string)
        return string
    }

    class func dateFromString(_ dd: Int, mm: Int, yyyy: Int) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: "\(dd)/\(mm)/\(yyyy)")!
    }

}
