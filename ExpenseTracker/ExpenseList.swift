//
//  ExpenseList.swift
//  ExpenseTracker
//
//  Created by Broderick Everitt-deJonge on 2025-03-04.
//

import SwiftData
import SwiftUI

struct ExpenseList: View {
    @Query(sort: \Expense.date, order: .reverse) private var expenses: [Expense]
    @Query(sort: \Category.title) private var categories: [Category]
    
    @Environment(\.modelContext) private var context
    @State private var newExpense: Expense?

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(expenses) { expense in
                    NavigationLink("\(expense.title) - \(expense.amount.formatted(.currency(code: "CAD")))") {
                        ExpenseDetail(expense: expense)
                    }
                }
                .onDelete(perform: deleteExpense(indexes:))
            }
            .navigationTitle("Expenses")
            .toolbar {
                ToolbarItem {
                    Button(
                        "Add Expense", systemImage: "plus", action: addExpense)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
            .sheet(item: $newExpense) { expense in
                NavigationStack {
                    ExpenseDetail(expense: expense, isNew: true)
                }
                .interactiveDismissDisabled()
            }
        } detail: {
            Text("Select an expense")
                .navigationTitle("Expense")
                .navigationBarTitleDisplayMode(.inline)
        }

    }

    private func addExpense() {
        let defaultCategory: Category
            if let firstCategory = categories.first {
                defaultCategory = firstCategory
            } else {
                // Create a default category if none exist
                defaultCategory = Category(title: "Default Category")
                context.insert(defaultCategory)
            }
        let defaultExpense = Expense(
            title: "",
            amount: 0,
            date: Date(),
            category: defaultCategory
        )
        context.insert(defaultExpense)
        self.newExpense = defaultExpense
    }

    private func deleteExpense(indexes: IndexSet) {
        for index in indexes {
            context.delete(expenses[index])
        }
    }
}

#Preview {
    ExpenseList()
        .modelContainer(SampleData.shared.modelContainer)
}
