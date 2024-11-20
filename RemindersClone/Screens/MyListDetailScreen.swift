//
//  MyListDetailScreen.swift
//  RemindersClone
//
//  Created by UsamaShafiq on 18/11/2024.
//

import SwiftUI
import SwiftData

struct MyListDetailScreen: View {
    
    let myList: MyList
    
    @State private var title: String = ""
    @State private var showReminderAlert: Bool = false
    
    @State private var selectedReminder: Reminder?
    @State private var showEditScreen = false


    var isValidForm: Bool {
        !title.isEmptyOrWhiteSpace
    }

    func saveReminder() {
        let reminder = Reminder(title: title)
        
        myList.reminders.append(reminder)
    }
    
    var body: some View {
        VStack {
            RemindersListView(reminders: myList.reminders.filter({!$0.isCompleted}))
            
            Spacer()
            
            Button(action: {
                showReminderAlert = true
            }, label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("New Reminder")
                }
            })
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .padding()
                
        }
        .navigationTitle(myList.name)
        .alert("Add New Reminder", isPresented: $showReminderAlert, actions: {
            TextField("title", text: $title)
            Button("Cancel", role: .cancel) {
                
            }
            
            Button("Done") {
                if isValidForm {
                    saveReminder()
                }
            }
        })
    }
}

struct MyListDetailScreenContainer: View {
    
    @Query private var myLists: [MyList]

    var body: some View {
        MyListDetailScreen(myList: myLists[0])
    }
}

#Preview { @MainActor in
    NavigationStack {
        MyListDetailScreenContainer()
    }
    .modelContainer(previewContainer)

}
