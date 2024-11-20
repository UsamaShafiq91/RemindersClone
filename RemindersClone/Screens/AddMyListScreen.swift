//
//  AddMyListScreen.swift
//  RemindersClone
//
//  Created by UsamaShafiq on 18/11/2024.
//

import SwiftUI

struct AddMyListScreen: View {
    
    @State private var listName = ""
    @State private var selectedColor = Color.blue
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    var myList: MyList?

    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "line.3.horizontal.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                    .foregroundStyle(selectedColor)
                
                TextField("List name", text: $listName)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                ColorPickerView(selectedColor: $selectedColor)
            }
            .navigationTitle("New List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading, content: {
                    Button("Close", action: {
                        dismiss()
                    })
                })
                
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button("Done", action: {
                        if let myList = myList {
                            myList.name = listName
                            myList.colorCode = selectedColor.toHex() ?? ""
                        }
                        else {
                            guard let hexColor = selectedColor.toHex() else {
                                return
                            }
                            
                            let myList = MyList(name: listName, colorCode: hexColor)
                            context.insert(myList)
                        }
                        
                        dismiss()
                    })
                })
            }
            .onAppear(perform: {
                if let myList = myList {
                    listName = myList.name
                    selectedColor = Color(hex: myList.colorCode)
                }
            })
        }
    }
}

#Preview { @MainActor in
    NavigationStack {
        AddMyListScreen()
    }
    .modelContainer(previewContainer)

}
