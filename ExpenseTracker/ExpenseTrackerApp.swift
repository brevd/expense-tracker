//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Broderick Everitt-deJonge on 2025-02-26.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Category.self, Expense.self])
    }
}
