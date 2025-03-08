//
//  ExpenseDetail.swift
//  ExpenseTracker
//
//  Created by Broderick Everitt-deJonge on 2025-03-07.
//

import SwiftUI
import SwiftData

struct ExpenseDetail: View {
    @Bindable var expense: Expense
    let isNew: Bool

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @Query(sort: \Category.title) private var categories: [Category]

    init(expense: Expense, isNew: Bool = false) {
        self.expense = expense
        self.isNew = isNew
    }

    var body: some View {
        Form {
            TextField("Title", text: $expense.title)
            DatePicker(
                "Date",
                selection: $expense.date,
                in: Date.distantPast...Date.now,
                displayedComponents: .date
            )
            HStack {
                Text("$")
                TextField(
                    "Amount",
                    value: $expense.amount,
                    format: .number
                )
                .keyboardType(.decimalPad)
            }

            HStack {
                Picker("Category", selection: $expense.category) {
                    ForEach(categories) { category in
                            Text(category.title)
                            .tag(category)
                    }
                }
                .pickerStyle(.menu)
            }
        }
        .navigationTitle(isNew ? "New Expense" : "Expense Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isNew {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        context.delete(expense)
                        dismiss()
                    }
                }
            }
        }
    }

}

#Preview {
    NavigationStack {
        ExpenseDetail(expense: SampleData.shared.expense)
    }
    .modelContainer(SampleData.shared.modelContainer)
}
#Preview("New Expense") {
    NavigationStack {
        ExpenseDetail(expense: SampleData.shared.expense, isNew: true)
    }
    .modelContainer(SampleData.shared.modelContainer)
}
