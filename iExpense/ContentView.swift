//
//  ContentView.swift
//  iExpense
//
//  Created by Cesar Lopez on 3/21/23.
//

import SwiftUI

struct CurrencyText: View {
    var amount: Double
    let currency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
    
    var body: some View {
        Text(amount, format: currency)
            .foregroundColor(amount <= 10 ? .black : amount <= 100 ? .green : .cyan )
    }
}

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(["Personal", "Business"], id: \.self) { type in
                    Section(type) {
                        ForEach(expenses.itemsForType(type)) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name).font(.headline)
                                    Text(item.type)
                                }
                                Spacer()
                                CurrencyText(amount: item.amount)
                            }
                        }
                        .onDelete { indexSet in
                            expenses.removeItems(at: indexSet, for: type)
                        }
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
