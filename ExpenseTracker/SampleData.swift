//
//  SampleData.swift
//  ExpenseTracker
//
//  Created by Broderick Everitt-deJonge on 2025-03-04.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
    static let shared = SampleData()

    let modelContainer: ModelContainer

    var context: ModelContext {
        modelContainer.mainContext
    }

    var expense: Expense {
        Expense(
            title: "Groceries",
            amount: 10.01,
            date: Date(),
            category: category(for: "Groceries")
        )
    }
    var category: Category {
        categories.last!
    }

    var categories: [Category] = []

    init() {
        let schema = Schema([
            Expense.self,
            Category.self,
        ])
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: true
        )
        do {
            modelContainer = try ModelContainer(
                for: schema, configurations: [modelConfiguration])
            insertSampleData()
            try context.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

    private func insertSampleData() {
        for category in Category.sampleData {
            context.insert(category)
            categories.append(category)
        }
        
       let sampleExpenseData = [
            Expense(
                title: "Groceries",
                amount: 10.01,
                date: Date(),
                category: category(for: "Groceries")
            ),
            Expense(title: "Rent", amount: 100.00, date: Date(),  category: category(for: "Utilities")),
            Expense(title: "Utilities", amount: 20.10, date: Date(), category: category(for: "Entertainment")),
        ]
       
        for expense in sampleExpenseData {
            context.insert(expense)
        }

    }
    private func category(for title: String) -> Category {
            return categories.last!
        }
}
