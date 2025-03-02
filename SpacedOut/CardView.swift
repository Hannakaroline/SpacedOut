//
//  CardView.swift
//  SpacedOut
//
//  Created by Hanna Torales Palacios on 2025/03/02.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var card: Card
    
    var body: some View {
        Form {
            TextField("Front card", text: $card.cardFront)
            TextField("Back card", text: $card.cardBack)
        }
        .navigationTitle("Edit title")
        .navigationBarTitleDisplayMode(.inline)
        .onSubmit {
            card.category?.objectWillChange.send()
            dataController.save()
        }
    }
}
