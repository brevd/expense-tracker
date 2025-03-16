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
    
    // Compute totalExpense correctly (remove optional handling)
    private var totalExpense: Double {
        category.expenses.reduce(0.0) { $0 + NSDecimalNumber(decimal: $1.amount).doubleValue }
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $category.title)
           
            if !category.expenses.isEmpty {
                Section(header: Text("Total: $\(totalExpense, specifier: "%.2f")")) {
                    ForEach(category.expenses) { expense in
                        HStack {
                            Text(expense.title)
                            Spacer()
                            Text("$\(NSDecimalNumber(decimal: expense.amount).doubleValue, specifier: "%.2f")")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            } else {
                Section {
                    Text("No expenses yet").foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle(isNew ? "New Category" : "\(category.title) ($\(totalExpense, specifier: "%.2f"))")
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
