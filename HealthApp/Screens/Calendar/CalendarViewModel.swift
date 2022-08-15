//
//  CalendarViewModel.swift
//  HealthApp
//
//  Created by Atay Sultangaziev on 13/8/22.
//

import UIKit

protocol CalendarViewModel {
  func getWeekDay(for date: Date) -> String
  func getDayNumber(for date: Date) -> String
  func getMonth(for date: Date) -> String
  func getYear(for date: Date) -> String
  func addDays(to date: Date, days: Int) -> Date
  func getSunday(for date: Date) -> Date
}

class CalendarViewModelImplementation: CalendarViewModel {
  
  private var formatter: DateFormatter
  private let calendar = Calendar.current
  
  init() {
    formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ru_RU")
  }
  
  func getWeekDay(for date: Date) -> String {
    formatter.dateFormat = "EE"
    return formatter.string(from: date)
  }
  
  func getDayNumber(for date: Date) -> String {
    formatter.dateFormat = "d"
    return formatter.string(from: date)
  }
  
  func getMonth(for date: Date) -> String {
    formatter.dateFormat = "LLLL"
    return formatter.string(from: date)
  }
  
  func getYear(for date: Date) -> String {
    formatter.dateFormat = "yyyy"
    return formatter.string(from: date)
  }
  
  func getSunday(for date: Date) -> Date {
    var current = date
    let oneWeekAgo = addDays(to: current, days: -7)
    while(current > oneWeekAgo) {
      let currentWeekDay = calendar.dateComponents([.weekday], from: current).weekday
      if(currentWeekDay == 2) {
        return current
      }
      current = addDays(to: current, days: -1)
    }
    return current
  }
  
  func addDays(to date: Date, days: Int) -> Date {
    return calendar.date(byAdding: .day, value: days, to: date)!
  }
}
