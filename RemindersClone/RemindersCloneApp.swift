//
//  RemindersCloneApp.swift
//  RemindersClone
//
//  Created by UsamaShafiq on 18/11/2024.
//

import SwiftUI

@main
struct RemindersCloneApp: App {
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {_,_ in
        })
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MyListsScreen()
            }
            .modelContainer(for: MyList.self)
        }
    }
}
