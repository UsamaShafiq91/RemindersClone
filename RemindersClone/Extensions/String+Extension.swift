//
//  String+Extension.swift
//  RemindersClone
//
//  Created by UsamaShafiq on 18/11/2024.
//

import Foundation

extension String {
    
    var isEmptyOrWhiteSpace: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
