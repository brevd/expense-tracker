//
//  FilteredExpenseList.swift
//  ExpenseTracker
//
//  Created by Broderick Everitt-deJonge on 2025-03-09.
//

import SwiftUI

struct FilteredExpenseList: View {
    @State private var searchText: String = ""

    var body: some View {
        NavigationSplitView {
            ExpenseList(titleFilter: searchText)
                .searchable(text: $searchText)
        } detail: {
            Text("Select an expense")
                .navigationTitle("Expense")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FilteredExpenseList().modelContainer(SampleData.shared.modelContainer)
}
