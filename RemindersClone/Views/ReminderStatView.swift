//
//  ReminderStatView.swift
//  RemindersClone
//
//  Created by UsamaShafiq on 19/11/2024.
//

import SwiftUI

struct ReminderStatView: View {
    
    let icon: String
    let title: String
    let count: Int
    
    var body: some View {
        GroupBox {
            HStack {
                VStack(spacing: 10) {
                    Image(systemName: icon)
                    Text(title)
                }
                
                Spacer()
                Text("\(count)")
                    .font(.largeTitle)
            }
        }
    }
}

#Preview {
    ReminderStatView(icon: "calendar", title: "Today", count: 9)
}
