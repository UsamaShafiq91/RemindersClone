//
//  MyListCellView.swift
//  RemindersClone
//
//  Created by UsamaShafiq on 19/11/2024.
//

import SwiftUI
import SwiftData

struct MyListCellView: View {
    
    let myList: MyList
    
    var body: some View {
        HStack {
            Image(systemName: "line.3.horizontal.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 32)
                .foregroundStyle(Color(hex: myList.colorCode))
            
            Text(myList.name)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
        }
        .padding(.vertical, 5)
        .contentShape(Rectangle())
    }
}

struct MyListCellViewContainer: View {
    
    @Query private var myList: [MyList]

    var body: some View {
        MyListCellView(myList: myList[0])
    }
}

#Preview {
    MyListCellViewContainer()
        .modelContainer(previewContainer)
}
