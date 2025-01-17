//
//  CalenderHelper.swift
//  SoftmonksCMSproject
//
//  Created by Shivakumar Harijan on 05/07/24.
//

import UIKit

class CalenderHelper {
    var calendar: Calendar
    
    init(){
        calendar = Calendar.current
        calendar.firstWeekday = 2
    }
    
    func plusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    func minusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    func monthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
    }
    
    func yearString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: date)
    }
    
    func daysInMonth(date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!

        return range.count
    }
    
    func dayOfMonth(date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    func firstOfMonth(date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    func weekDay(date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
//        return components.weekday! - 1
        return (components.weekday! + 5) % 7 + 1
    }
    
}

struct DayInfo: Codable {
    let date: String?
    let isMonth: Int?
    let isToday: Int?
    let calDOW: String?
    let day: String?
    let birthday: Int?
    let holiday: Int?
    let leaves: Int?
    let meeting: Int?
    let agenda: Int?
}

// Define the struct for the overall structure
struct CalendarDataResponse: Codable {
    let dayOfWeek: [String]
    let currentMonth: String?
    let prevMonth: String?
    let nextMonth: String?
    let monthArr: [DayInfo]
}
