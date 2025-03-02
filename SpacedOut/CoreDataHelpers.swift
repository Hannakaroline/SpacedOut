//
//  CoreDataHelpers.swift
//  SpacedOut
//
//  Created by Hanna Torales Palacios on 2025/02/15.
//

import Foundation

extension Category {
    var categoryName: String {
        get { name ?? "(Unnamed Category)" }
        set { name = newValue }
    }
    
    var categoryCreationDate: Date {
        get { creationDate ?? .now }
        set { creationDate = newValue }
    }
    
    var categoryCards: [Card] {
        let array = cards?.allObjects as? [Card] ?? []
        return array.sorted()
    }
}

extension Card {
    var cardFront: String {
        get { front ?? "Card Front" }
        set { front = newValue }
    }
    
    var cardBack: String {
        get { back ?? "Card Back" }
        set { back = newValue }
    }
    
    var cardCreationDate: Date {
        get { creationDate ?? .now }
        set { creationDate = newValue }
    }
}

extension Card: Comparable {
    public static func <(lhs: Card, rhs: Card) -> Bool {
        if lhs.cardFront == rhs.cardFront {
            if lhs.cardBack == rhs.cardBack {
                return lhs.cardCreationDate < rhs.cardCreationDate
            } else {
                return lhs.cardBack < rhs.cardBack
            }
        } else {
            return lhs.cardFront < rhs.cardFront
        }
    }
}
