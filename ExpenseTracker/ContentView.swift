//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Broderick Everitt-deJonge on 2025-02-26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Tab("Expenses", systemImage: "creditcard.fill") {
                ExpenseList()
            }
            Tab("Categories", systemImage: "window.horizontal.closed") {
               CategoryList()
            }
        }
    }
}

#Preview {
    ContentView().modelContainer(SampleData.shared.modelContainer)
}
