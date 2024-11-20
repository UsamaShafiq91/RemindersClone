//
//  ReminderEditScreen.swift
//  RemindersClone
//
//  Created by UsamaShafiq on 19/11/2024.
//

import SwiftUI
import SwiftData

struct ReminderEditScreen: View {
    
    let reminder: Reminder
    @State private var title = ""
    @State private var notes = ""
    @State private var reminderDate = Date.now
    @State private var reminderTime = Date.now

    @State private var showCalender = false
    @State private var showTime = false

    @Environment(\.dismiss) var dismiss
    
    var isValidForm: Bool {
        !title.isEmptyOrWhiteSpace
    }
    
    func updateReminder() {
        reminder.title = title
        reminder.notes = notes.isEmpty ? nil : notes
        reminder.reminderDate = showCalender ? reminderDate : nil
        reminder.reminderTime = showTime ? reminderTime : nil
        
        NotificationManager.scheduleNotification(userData: UserData(title: reminder.title, body: reminder.notes, date: reminder.reminderDate, time: reminder.reminderTime))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Notes", text: $notes)
                }
                
                Section {
                    Toggle(isOn: $showCalender, label: {
                        Image(systemName: "calendar")
                            .font(.title2)
                            .foregroundStyle(.red)
                    })
                    
                    if showCalender {
                        DatePicker("Select Date",
                                   selection: $reminderDate,
                                   in: Date.now...Date.distantFuture,
                                   displayedComponents: .date)
                    }
                    
                    Toggle(isOn: $showTime, label: {
                        Image(systemName: "clock")
                            .font(.title2)
                            .foregroundStyle(.blue)
                    })
                    .onChange(of: showTime, {
                        if showTime {
                            showCalender = true
                        }
                    })
                    
                    if showTime {
                        DatePicker("Select Time",
                                   selection: $reminderTime,
                                   displayedComponents: .hourAndMinute)
                    }
                }
            }
            .onAppear(perform: {
                title = reminder.title
                notes = reminder.notes ?? ""
                reminderDate = reminder.reminderDate ?? .now
                reminderTime = reminder.reminderTime ?? .now
                
                showCalender = reminder.reminderDate != nil
                showTime = reminder.reminderTime != nil
            })
            .navigationTitle("Detail")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading, content: {
                    Button("Close") {
                        dismiss()
                    }
                })
                
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button("Done") {
                        updateReminder()
                        dismiss()
                    }
                    .disabled(!isValidForm)
                })
            }
        }
    }
}

struct ReminderEditScreenContainer: View {
    
    @Query private var reminders: [Reminder]

    var body: some View {
        ReminderEditScreen(reminder: reminders[0])
    }
}

#Preview { @MainActor in
    NavigationStack {
        ReminderEditScreenContainer()
    }
    .modelContainer(previewContainer)

}


