//
//  MyListScreen.swift
//  RemindersClone
//
//  Created by UsamaShafiq on 18/11/2024.
//

import SwiftUI
import SwiftData

enum MyListScreenSheets: Identifiable {
    case newList
    case editList(MyList)
    
    var id: Int {
        switch self {
        case .newList:
            return 1
        case .editList(let myList):
            return myList.hashValue
        }
    }
}

enum ReminderStatType {
    case all
    case today
    case scheduled
    case completed
    
    var title: String {
        switch self {
        case .all:
            "All"
        case .completed:
            "Completed"
        case .scheduled:
            "Scheduled"
        case .today:
            "Today"
        }
    }
}

struct MyListsScreen: View {
    
    @Query private var myLists: [MyList]
    
    @State private var isPresented = false
    
    @State private var selectedList: MyList?
    @State private var actionSheet: MyListScreenSheets?
    
    @Query private var reminders: [Reminder]
    
    @State private var searchText = ""
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.colorScheme) var colorScheme

    var todayReminders: [Reminder] {
        reminders.filter({
            guard let reminderDate = $0.reminderDate else {
                return false
            }
            
            return reminderDate.isToday && !$0.isCompleted
        })
    }
    
    var scheduledReminders: [Reminder] {
        reminders.filter({
            return $0.reminderDate != nil && !$0.isCompleted
        })
    }
    
    var incompleteReminders: [Reminder] {
        reminders.filter{ !$0.isCompleted }
    }
    
    var completeReminders: [Reminder] {
        reminders.filter{ $0.isCompleted }
    }
    
    var searchReminders: [Reminder] {
        reminders.filter{ !$0.isCompleted && $0.title.localizedCaseInsensitiveContains(searchText)}
    }
    
    @State private var reminderStatType: ReminderStatType?
    private func getRemindersFor(type: ReminderStatType) -> [Reminder] {
        switch type {
        case .all:
            return incompleteReminders
        case .completed:
            return completeReminders
        case .scheduled:
            return scheduledReminders
        case .today:
            return todayReminders
        }
    }
    
    private func deleteList(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        
        let list = myLists[index]
        
        modelContext.delete(list)
    }
    
    var body: some View {
        
        List {
            VStack {
                HStack {
                    ReminderStatView(icon: "calendar", 
                                     title: "Today",
                                     count: todayReminders.count)
                    .onTapGesture {
                        reminderStatType = .today
                    }
                    
                    ReminderStatView(icon: "calendar.circle.fill",
                                     title: "Scheduled",
                                     count: scheduledReminders.count)
                    .onTapGesture {
                        reminderStatType = .scheduled
                    }
                }
                
                HStack {
                    ReminderStatView(icon: "tray.circle.fill", 
                                     title: "All",
                                     count: incompleteReminders.count)
                    .onTapGesture {
                        reminderStatType = .all
                    }
                    
                    ReminderStatView(icon: "checkmark.circle.fill",
                                     title: "Completed",
                                     count: completeReminders.count)
                    .onTapGesture {
                        reminderStatType = .completed
                    }
                }
            }
            
            ForEach(myLists, id: \.self) { myList in
                NavigationLink(value: myList, label: {
                    MyListCellView(myList: myList)
                        .onTapGesture {
                            selectedList = myList
                        }
                        .onLongPressGesture(minimumDuration: 0.5, perform: {
                            actionSheet = .editList(myList)
                        })
                })
            }
            .onDelete(perform: deleteList)
            
            Button(action: {
                actionSheet = .newList
            }, label: {
                Text("Add List")
            })
            .foregroundStyle(.blue)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationTitle("My List")
        .navigationDestination(item: $reminderStatType,
                               destination: { reminderStatType in
            NavigationStack {
                RemindersListView(reminders: getRemindersFor(type: reminderStatType))
                    .navigationTitle(reminderStatType.title)
            }
        })
        .navigationDestination(item: $selectedList,
                               destination: { myList in
            MyListDetailScreen(myList: myList)
        })
        .sheet(item: $actionSheet,
               content: { action in
            switch action {
            case .newList:
                AddMyListScreen()
            case .editList(let myList):
                AddMyListScreen(myList: myList)
            }
        })
        .searchable(text: $searchText, prompt: "Search")
        .overlay(content: {
            if !searchReminders.isEmpty {
                RemindersListView(reminders: searchReminders)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                    .background(colorScheme == .dark ? .black : .white)
            }
        })
    }
}

#Preview { @MainActor in
    NavigationStack {
        MyListsScreen()
    }
    .modelContainer(previewContainer)
        
}
