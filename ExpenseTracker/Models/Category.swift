//
//  Category.swift
//  ExpenseTracker
//
//  Created by Broderick Everitt-deJonge on 2025-03-04.
//

import Foundation
import SwiftData

@Model
class Category  {
    var title: String
    @Relationship(deleteRule: .cascade, inverse: \Expense.category)
    var expenses = [Expense]()
    
    init(title: String) {
        self.title = title
    }
    
    static let sampleData = [
        Category(title: "Groceries"),
        Category(title: "Utilities"),
        Category(title: "Entertainment"),
        Category(title: "Transportation"),
        Category(title: "Clothing"),
        Category(title: "Miscellaneous"),
    ]
}
