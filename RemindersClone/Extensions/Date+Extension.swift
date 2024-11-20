//
//  Date+Extension.swift
//  RemindersClone
//
//  Created by UsamaShafiq on 19/11/2024.
//

import Foundation

extension Date {
    
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    var isTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
    
    var dateTimeComponents: DateComponents {
        Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self)
    }
}
