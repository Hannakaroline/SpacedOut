//
//  CategoryRow.swift
//  SpacedOut
//
//  Created by Hanna Torales Palacios on 2025/03/02.
//

import SwiftUI

struct CategoryRow: View {
    @ObservedObject var category: Category
    
    var body: some View {
        NavigationLink(value: category) {
            HStack {
                if category.active {
                    Image(systemName: "star")
                        .symbolVariant(.fill)
                }
                Text(category.categoryName)
            }
            .badge(category.categoryCards.count)
        }
    }
}
