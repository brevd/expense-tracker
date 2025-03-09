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
    
    // Add a sum of totalExpense
    private var totalExpense: Double {
        category.expenses.reduce(0.0) { $0 + (Double(truncating: $1.amount as NSNumber)) }
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $category.title)
           
            if !category.expenses.isEmpty {
                Section(header: Text("Total: \(String(format: "%.2f", totalExpense))")) {
                    ForEach(category.expenses) { expense in
                        HStack {
                            Text(expense.title)
                            Spacer()
                            Text(String(format: "%.2f", Double(truncating: expense.amount as NSNumber)))
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
        .navigationTitle(isNew ? "New Category" : "\(category.title) (\(totalExpense, specifier: "%.2f"))")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isNew {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        do {
                            try context.save()
                            dismiss()
                        } catch {
                            print("Error saving category: \(error)")
                        }
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

