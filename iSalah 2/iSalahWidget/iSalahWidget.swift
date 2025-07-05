//
//  iSalahWidget.swift
//  iSalahWidget
//
//  Created by Tharindu Perera on 9/27/20.
//

import WidgetKit
import SwiftUI

struct iSalahWidgetEntryView : View {
    var entry: iSalahTimelineProvider.Entry

    @Environment(\.widgetFamily) var family
    
    var body: some View {
        ZStack {
            Color.backgroundColor
            if let message = entry.message {
                Text(message)
                    .font(.getWidgetFont(size: 15.0))
                    .foregroundColor(.primaryDarkColor)
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                switch family {
                case .systemSmall:
                    SmallWidgetView(entry: entry)
                case .systemMedium:
                    MediumWidgetView(entry: entry)
                case .systemLarge:
                    LargeWidgetView(entry: entry)
                @unknown default:
                    Text("Unsupported Device")
                }
            }
        }
    }
}

@main
struct iSalahWidget: Widget {
    let kind: String = "iSalahWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: iSalahTimelineProvider()) { entry in
            iSalahWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("iSalah Widget")
        .description("Check prayer times based on your location.")
    }
}
