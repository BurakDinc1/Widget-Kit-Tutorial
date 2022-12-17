//
//  UserListWidget.swift
//  UserListWidget
//
//  Created by Burak Dinç on 17.12.2022.
//

import WidgetKit
import SwiftUI

struct UserListWidgetEntryView : View {
    var entry: UserListWidgetProvider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:
            Text("Small Widget")
        case .systemMedium:
            Text("Medium Widget")
        case .systemLarge:
            UserListLargeWidget(userListEntry: entry)
        default:
            Text("Default Widget")
        }
    }
}

@main
struct UserListWidget: Widget {
    let kind: String = "UserListWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: UserListWidgetProvider()) { entry in
            UserListWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Widget Kit App")
        .description("Show user list for your app.")
    }
}

struct UserListWidget_Previews: PreviewProvider {
    static var previews: some View {
        UserListWidgetEntryView(entry: UserListWidgetEntry.placeholder)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
