//
//  ReminderCellView.swift
//  RemindersClone
//
//  Created by UsamaShafiq on 19/11/2024.
//

import SwiftUI
import SwiftData

enum ReminderCellEvents {
    case onChecked(Reminder, Bool)
    case onSelect(Reminder)
}

struct ReminderCellView: View {
    
    let reminder: Reminder
    let onEvent: (ReminderCellEvents) -> Void
    @State private var checked = false
    
    
    func formattedReminderDate(date: Date) -> String {
        var formattedDate = ""
        
        if date.isToday {
            formattedDate = "Today"
        }
        else if date.isTomorrow {
            formattedDate = "Tomorrow"
        }
        else {
            formattedDate = date.formatted(date: .numeric,
                                           time: .omitted)
        }
        
        return formattedDate
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: checked ? "circle.inset.filled" : "circle")
                .font(.title2)
                .onTapGesture {
                    checked.toggle()
                    
                    onEvent(.onChecked(reminder, checked))
                }
            
            VStack {
                Text(reminder.title)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                
                if let notes = reminder.notes {
                    Text(notes)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                }
                
                HStack {
                    if let reminderDate = reminder.reminderDate {
                        Text(formattedReminderDate(date: reminderDate))
                    }
                    
                    if let reminderTime = reminder.reminderTime {
                        Text(reminderTime, style: .time)
                    }
                }
                .font(.caption)
                .foregroundStyle(.gray)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            }
            
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onEvent(.onSelect(reminder))
        }
    }
}

struct ReminderDetailScreenContainer: View {
    
    @Query private var reminders: [Reminder]

    var body: some View {
        ReminderCellView(reminder: reminders[0], onEvent: {_ in })
    }
}

#Preview { @MainActor in
    NavigationStack {
        ReminderDetailScreenContainer()
    }
    .modelContainer(previewContainer)

}

