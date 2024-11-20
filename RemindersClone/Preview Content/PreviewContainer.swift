//
//  PreviewContainer.swift
//  RemindersClone
//
//  Created by UsamaShafiq on 18/11/2024.
//

import Foundation
import SwiftData

@MainActor
var previewContainer: ModelContainer {
    
    let container = try! ModelContainer(for: MyList.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    for mylist in SampleData.myLists {
        container.mainContext.insert(mylist)
        
        mylist.reminders = SampleData.reminders
    }
    
    return container
}


struct SampleData {
    
    static var myLists: [MyList] {
        return [MyList(name: "Reminders", colorCode: "#347C59"),
                MyList(name: "Backlog", colorCode: "#FFCC00")]
    }
    
    static var reminders: [Reminder] {
        return [Reminder(title: "Reminder 1", notes: "This is reminder 1", reminderDate: Date(), reminderTime: Date()),
                Reminder(title: "Reminder 2", notes: "This is reminder 1", reminderDate: Date(), reminderTime: Date())]
    }
}
