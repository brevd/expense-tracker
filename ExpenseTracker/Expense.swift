//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Broderick Everitt-deJonge on 2025-03-04.
//

import Foundation
import SwiftData

@Model
class Expense {
    var title: String
    var amount: Decimal
    var date: Date
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    var category: Category?

    init(title: String, amount: Decimal, date: Date, category: Category) {
        self.title = title
        self.amount = amount
        self.date = date
        self.category = category
    }
}
