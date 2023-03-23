//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Cesar Lopez on 3/22/23.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double    
}
