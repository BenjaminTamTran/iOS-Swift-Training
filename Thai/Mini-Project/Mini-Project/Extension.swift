//
//  Extension.swift
//  Anymex
//
//  Created by Sonivy Development on 2/25/16.
//  Copyright © 2016 Sonivy Development. All rights reserved.
//

import Foundation

extension String
{
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    func count() -> Int {
        return self.characters.count
    }
    
    func isValidEmail() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: .CaseInsensitive)
            return regex.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
}

extension NSDate
{
    func day() -> Int {
        //Get Day
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Day, fromDate: self)
        return components.day
    }
    func month() -> Int {
        //Get Month
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Month, fromDate: self)
        return components.month
    }
    
    func thu() -> String {
        //Get thu
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(NSCalendarUnit.Weekday, fromDate: self)
        let strThu = dayOfWeek[String(components.weekday)]
        return strThu!
    }
    
    func hour() -> Int
    {
        //Get Hour
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Hour, fromDate: self)
        let hour = components.hour
        //Return Hour
        return hour
    }
    
    func minute() -> Int
    {
        //Get Minute
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Minute, fromDate: self)
        let minute = components.minute
        //Return Minute
        return minute
    }
    
    func year() -> Int
    {
        //Get Minute
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Year, fromDate: self)
        let year = components.year
        //Return Minute
        return year
    }
    
    func toShortTimeString() -> String
    {
        //Get Short Time String
        let formatter = NSDateFormatter()
        formatter.dateFormat = "hh:mm a"
        let timeString = formatter.stringFromDate(self)
        //Return Short Time String
        return timeString
    }
    
    func toThuF() -> String
    {
        //Get thu
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(NSCalendarUnit.Weekday , fromDate: self)
        return dayOfWeekFull[ dayOfWeek[String(components.weekday)]!]!
    }
    
    func toMonthF() -> String
    {
        return monthOfYear[String(self.month())]!
    }
    
    func toShortDayString() -> String {
        return String("\(self.toThuF()), \(self.toMonthF()) \(self.day()), \(self.year())")
    }
    
    func nextDay() -> NSDate {
        let tomorrow = NSCalendar.currentCalendar().dateByAddingUnit (
            .Day,
            value: 1,
            toDate: self,
            options: NSCalendarOptions(rawValue: 0))
        return tomorrow!
    }
    
    class func stringToDateOption(strDate: String!, format: String = "EEEE, MMMM dd, yyyy") -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.dateFromString(strDate)
    }
    
    func toShortTime() -> String {
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "HH:mm"
        let strDateChanged = dateFormat.stringFromDate(self)
        return strDateChanged
    }
    
    func yearsFrom(date:NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Year, fromDate: date, toDate: self, options: []).year
    }
    
    func monthsFrom(date:NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Month, fromDate: date, toDate: self, options: []).month
    }
    
    func weeksFrom(date:NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.WeekOfYear, fromDate: date, toDate: self, options: []).weekOfYear
    }
    
    func daysFrom(date:NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Day, fromDate: date, toDate: self, options: []).day
    }
    
    func hoursFrom(date:NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Hour, fromDate: date, toDate: self, options: []).hour
    }
    
    func minutesFrom(date:NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Minute, fromDate: date, toDate: self, options: []).minute
    }
    
    func secondsFrom(date:NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Second, fromDate: date, toDate: self, options: []).second
    }
   
    func offsetFrom(date:NSDate) -> String {
        if yearsFrom(date)   > 0 { return "\(yearsFrom(date))y"   }
        if monthsFrom(date)  > 0 { return "\(monthsFrom(date))M"  }
        if weeksFrom(date)   > 0 { return "\(weeksFrom(date))w"   }
        if daysFrom(date)    > 0 { return "\(daysFrom(date))d"    }
        if hoursFrom(date)   > 0 { return "\(hoursFrom(date))h"   }
        if minutesFrom(date) > 0 { return "\(minutesFrom(date))m" }
        if secondsFrom(date) > 0 { return "\(secondsFrom(date))s" }
        return ""
    }
}
