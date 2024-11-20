//
//  RemindersListView.swift
//  RemindersClone
//
//  Created by UsamaShafiq on 19/11/2024.
//

import SwiftUI
import SwiftData

struct RemindersListView: View {
    
    var reminders: [Reminder]
    
    @State private var remindersIdAndDelay: [PersistentIdentifier: Delay] = [:]
        
    @Environment(\.modelContext) var modelContext

    @State private var selectedReminder: Reminder?
    
    func isSelectedReminder(reminder: Reminder) -> Bool {
        return selectedReminder?.persistentModelID == reminder.persistentModelID
    }
    
    func deleteReminder(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        
        let reminder = reminders[index]
        
        modelContext.delete(reminder)
    }
    
    var body: some View {
        List {
            ForEach(reminders) {
                reminder in
                
                ReminderCellView(reminder: reminder,
                                 onEvent: { event in
                    switch event {
                    case .onChecked(let reminder, let checked):
                        
                        var delay = remindersIdAndDelay[reminder.persistentModelID]
                        
                        if let delay {
                            delay.cancel()
                            remindersIdAndDelay.removeValue(forKey: reminder.persistentModelID)
                        }
                        else {
                            delay = Delay()
                            remindersIdAndDelay[reminder.persistentModelID] = delay
                            
                            delay?.performWork {
                                reminder.isCompleted = checked
                            }
                        }
                        
                    case .onSelect(let reminder):
                        selectedReminder = reminder
                    }
                })
            }
            .onDelete(perform: deleteReminder)
        }
        .sheet(item: $selectedReminder, content: {selectedReminder in
            ReminderEditScreen(reminder: selectedReminder)
        })
    }
}

struct RemindersListViewContainer: View {
    
    @Query private var reminders: [Reminder]

    var body: some View {
        RemindersListView(reminders: reminders)
    }
}

#Preview {
    RemindersListViewContainer()
        .modelContainer(previewContainer)
}
