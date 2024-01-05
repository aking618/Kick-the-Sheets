//
//  DailyProgressWidget.swift
//  DailyProgressWidget
//
//  Created by Ayren King on 10/15/23.
//

import Services
import Shared
import SwiftUI
import WidgetKit

struct DailyProgressProvider: TimelineProvider {
    func placeholder(in _: Context) -> DailyProgressEntry {
        DailyProgressEntry(date: Date(), entity: .init(todoCount: 3, todosCompleted: 7))
    }

    func getSnapshot(in _: Context, completion: @escaping (DailyProgressEntry) -> Void) {
        let entry = DailyProgressEntry(date: Date(), entity: .init(todoCount: 3, todosCompleted: 7))
        completion(entry)
    }

    func getTimeline(in _: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let currentDate = Date()

        let entryDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!

        let service = GeneralTodoService()
        var todos = [Todo]()
        let days = service.retrieveDays()
        if let currenDay = days[Date().key] {
            todos =
                service.retrieveTodos(for: currenDay.id)
        } else {
            if let currentDayId = service.insertDay() {
                todos = []
            }
        }

        let entry = DailyProgressEntry(date: entryDate, entity: .init(todoCount: todos.count, todosCompleted: todos.filter { $0.status }.count))

        let timeline = Timeline(
            entries: [entry],
            policy: .after(entryDate)
        )

        completion(timeline)
    }
}

struct DailyProgressEntry: TimelineEntry {
    let date: Date
    let entity: DailyProgressData
}

struct DailyProgressData {
    let todoCount: Int
    let todosCompleted: Int
}

struct DailyProgressWidgetEntryView: View {
    var entry: DailyProgressProvider.Entry

    var body: some View {
        VStack {
            CircularProgressView(
                progress: entry.entity.todoCount,
                total: entry.entity.todosCompleted
            )
        }
    }
}

struct DailyProgressWidget: Widget {
    let kind: String = "DailyProgressWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: DailyProgressProvider()) { entry in
            if #available(iOS 17.0, *) {
                DailyProgressWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                DailyProgressWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Daily Progress")
        .description("Shows your completion status for today's tasks.")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    DailyProgressWidget()
} timeline: {
    DailyProgressEntry(date: .now, entity: .init(todoCount: 3, todosCompleted: 7))
    DailyProgressEntry(date: .now, entity: .init(todoCount: 5, todosCompleted: 7))
}
