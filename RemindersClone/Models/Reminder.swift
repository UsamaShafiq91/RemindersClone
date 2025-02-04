//
//  Reminder.swift
//  RemindersClone
//
//  Created by UsamaShafiq on 18/11/2024.
//

import Foundation
import SwiftData

@Model
class Reminder {
    
    var title: String
    var notes: String?
    var isCompleted: Bool
    var reminderDate: Date?
    var reminderTime: Date?
    
    var myList: MyList?
    
    init(title: String, notes: String? = nil, isCompleted: Bool = false, reminderDate: Date? = nil, reminderTime: Date? = nil, myList: MyList? = nil) {
        self.title = title
        self.notes = notes
        self.isCompleted = isCompleted
        self.reminderDate = reminderDate
        self.reminderTime = reminderTime
        self.myList = myList
    }
}
