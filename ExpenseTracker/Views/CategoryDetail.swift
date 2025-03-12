//
//  CategoryDetail.swift
//  ExpenseTracker
//
//  Created by Broderick Everitt-deJonge on 2025-03-08.
//

import SwiftUI

struct CategoryDetail: View {
    @Bindable var category: Category
    let isNew: Bool

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    init(category: Category, isNew: Bool = false) {
        self.category = category
        self.isNew = isNew
    }
    
    var sortedExpenses: [Expense] {
        category.expenses.sorted { first, second in
            first.createdAt > second.createdAt
        }
    }

    var body: some View {
        Form {
            TextField("Title", text: $category.title)
           
            if !category.expenses.isEmpty {
                Section("Related Expenses") {
                    ForEach(sortedExpenses) { expense in
                        Text(expense.title)

                    }
                }
            }
        }
        .navigationTitle(isNew ? "New Category" : "Category Detail")
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
                        context.delete(category)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CategoryDetail(category: SampleData.shared.category)
    }
    .modelContainer(SampleData.shared.modelContainer)
}
