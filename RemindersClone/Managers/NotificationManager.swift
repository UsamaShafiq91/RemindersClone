//
//  NotificationManager.swift
//  RemindersClone
//
//  Created by UsamaShafiq on 20/11/2024.
//

import Foundation
import NotificationCenter

struct UserData {
    var title: String?
    var body: String?
    var date: Date?
    var time: Date?
}

struct NotificationManager {
    
    static func scheduleNotification(userData: UserData) {
        let content = UNMutableNotificationContent()
        content.title = userData.title ?? "Notification from Reminder App 🔔"
        content.body = userData.body ?? ""
        
        var dateComponents = (userData.date ?? Date()).dateTimeComponents
        
        if let time = userData.time {
            let dateTimeComponents = time.dateTimeComponents
            
            dateComponents.hour = dateTimeComponents.hour
            dateComponents.minute = dateTimeComponents.minute
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        UNUserNotificationCenter.current().add(UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger))
    }
}
