//
//  SpacedOutWidget.swift
//  SpacedOutWidget
//
//  Created by Hanna Torales Palacios on 2025/03/02.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    static var dataController = DataController()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: .now, emoji: "📚", text: "Example card")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let cards = loadCards()
        let text = cards.first ?? "Example Card"
        let entry = SimpleEntry(date: .now, emoji: "📚", text: text)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries =  [SimpleEntry]()
        let cards = loadCards()

        if cards.isEmpty {
            let entry = SimpleEntry(date: .now, emoji: "📚", text: "No Active Categories")
            entries.append(entry)
        } else {
            let currentDate = Date.now
            let minuteOffset = 0
            
            for card in cards {
                let date = Calendar.current.date(byAdding: .second, value: minuteOffset * 3, to: currentDate) ?? .now
                let entry = SimpleEntry(date: date, emoji: "📚", text: card)
                minuteOffset += 1
            }
        }
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    func loadCards() -> [String] {
        let request = Category.fetchRequest()
        request.predicate = NSPredicate(format: "active = true")
        
        let categories = (try? Self.dataController.container.viewContext.fetch(request)) ?? []
        let items = categories.reduce(into: [String()]) { array, category in
            for card in category.categoryCards {
                array.append(card.cardFront)
                array.append(card.cardBack)
            }
        }
        return items.shuffled()
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
    var text: String
}

struct SpacedOutWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)

            Text("Emoji:")
            Text(entry.emoji)
        }
    }
}

struct SpacedOutWidget: Widget {
    let kind: String = "SpacedOutWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                SpacedOutWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                SpacedOutWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    SpacedOutWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀", text: "yay")
    SimpleEntry(date: .now, emoji: "🤩", text: "wow")
}
