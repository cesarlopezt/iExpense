//
//  Expenses.swift
//  iExpense
//
//  Created by Cesar Lopez on 3/22/23.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded =  try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    func itemsForType(_ type: String) -> [ExpenseItem] {
      items.filter { $0.type == type }
    }
    
    func removeItems(at offsets: IndexSet, for type: String) {
        let element = itemsForType(type)[offsets.first!]
        let index = items.firstIndex(where: {$0.id == element.id})!
        items.remove(at: index)
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }

}
