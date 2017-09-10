//
//  Utils.swift
//  HYCalendar
//
//  Created by Harry on 31/03/17.
//  Copyright © 2017 Harry. All rights reserved.
//

import UIKit

public extension Date {
    func addDateComponentsInDate(_ daysToAdd:Int = 0, monthsToAdd:Int = 0, yearsToAdd:Int = 0) -> Date {
        var dateComp = (Calendar.current as NSCalendar).components([.day, .month, .year], from: self)
        dateComp.day = dateComp.day! + daysToAdd
        dateComp.month = dateComp.month! + monthsToAdd
        dateComp.year = dateComp.year! + yearsToAdd
        return Calendar.current.date(from: dateComp)!
    }

    func getMonthFromDateForCalendar() -> Int {
        let dateComp = (Calendar.current as NSCalendar).components([.day, .month, .year], from: self)
        return dateComp.month!
    }

    func getDayTitleFromDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }

    func getYearFromDateForCalendar() -> Int {
        let dateComp = (Calendar.current as NSCalendar).components([.day, .month, .year], from: self)
        return dateComp.year!
    }

    func isBetweeen(date date1: Date, andDate date2: Date) -> Bool {
        return date1.compare(self).rawValue * self.compare(date2).rawValue > 0
    }

    func isGreaterThanDate(_ dateToCompare: Date) -> Bool {
        var isGreater = false
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        return isGreater
    }

    func isLessThanDate(_ dateToCompare: Date) -> Bool {
        var isLess = false
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isLess = true
        }
        return isLess
    }
}

extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

class Utils {
    class func hexStringToUIColorWithAlphaComponent (_ hex:String, alphaComponenet : Float) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: cString.characters.index(cString.startIndex, offsetBy: 1))
        }

        if (cString.characters.count != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alphaComponenet)
        )
    }
}
