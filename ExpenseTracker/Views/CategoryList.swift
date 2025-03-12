//
//  CategoryList.swift
//  ExpenseTracker
//
//  Created by Broderick Everitt-deJonge on 2025-03-08.
//

import SwiftData
import SwiftUI

struct CategoryList: View {
    @Query(sort: \Category.title) private var categories: [Category]
    @Environment(\.modelContext) private var context
    @State private var newCategory: Category?

    var body: some View {
        NavigationSplitView {
            Group {
                if !categories.isEmpty {
                    List {
                        ForEach(categories) { category in
                            NavigationLink("\(category.title)") {
                                CategoryDetail(category: category)
                            }
                        }
                        .onDelete(perform: deleteCategory(indexes:))
                    }
                } else {
                    ContentUnavailableView(
                        "Add some categories", systemImage: "window.horizontal.closed")
                }
            }
            .navigationTitle("Categories")
            .toolbar {
                ToolbarItem {
                    Button(
                        "Add Category", systemImage: "plus", action: addCategory
                    )
                }
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
            .sheet(item: $newCategory) { category in
                NavigationStack {
                    CategoryDetail(category: category, isNew: true)
                }
                .interactiveDismissDisabled()
            }
        } detail: {
            Text("Select a category")
                .navigationTitle("Category")
                .navigationBarTitleDisplayMode(.inline)
        }

    }
    private func addCategory() {
        let defaultCategory = Category(title: "")
        context.insert(defaultCategory)
        self.newCategory = defaultCategory
    }

    private func deleteCategory(indexes: IndexSet) {
        for index in indexes {
            context.delete(categories[index])
        }
    }
}

#Preview {
    CategoryList()
        .modelContainer(SampleData.shared.modelContainer)
}
