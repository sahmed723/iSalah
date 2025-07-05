//
//  iSalahWidget.swift
//  iSalahWidget
//
//  Created on 9/27/20.
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
        IntentConfiguration(kind: kind, intent: RefreshIntervalIntent.self, provider: iSalahTimelineProvider()) { entry in
            iSalahWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("iSalah Widget")
        .description("Check prayer times based on your location.")
    }
}

struct SmallWidgetView : View {
    var entry: iSalahTimelineProvider.Entry
    
    var body: some View {
        let preferredMax = 3
        let maxRows = (entry.prayerTimes.count > preferredMax) ? preferredMax : entry.prayerTimes.count
        VStack(alignment: .center) {
            PrayerTimeSmallRow(prayerTime: entry.prayerTimes[0])
            if maxRows > 1 {
                Divider()
                PrayerTimeSmallRow(prayerTime: entry.prayerTimes[2])
            }
            if maxRows > 2 {
                Divider()
                PrayerTimeSmallRow(prayerTime: entry.prayerTimes[3])
            }
        }
        .padding(.vertical, 8)
    }
}

struct MediumWidgetView : View {
    var entry: iSalahTimelineProvider.Entry
    
    var body: some View {
        let preferredMax = 4
        let maxRows = (entry.prayerTimes.count > preferredMax) ? preferredMax : entry.prayerTimes.count
        VStack(alignment: .center) {
            HStack {
                PrayerTimeSmallRow(prayerTime: entry.prayerTimes[0])
                if maxRows > 1 {
                    Divider()
                    PrayerTimeSmallRow(prayerTime: entry.prayerTimes[2])
                }
            }
            if maxRows > 2 {
                Divider()
                HStack {
                    PrayerTimeSmallRow(prayerTime: entry.prayerTimes[3])
                    if maxRows > 3 {
                        Divider()
                        PrayerTimeSmallRow(prayerTime: entry.prayerTimes[4])
                    }
                }
            }
        }
        .padding(.vertical, 8)
    }
}

struct LargeWidgetView : View {
    var entry: iSalahTimelineProvider.Entry
    
    var body: some View {
        let preferredMax = 5
        let maxRows = (entry.prayerTimes.count > preferredMax) ? preferredMax : entry.prayerTimes.count
        VStack(alignment: .center) {
            Text("\(UserData.getSelectedSchoolOfThought().name)")
                .font(.getWidgetFont())
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.all)
                .background(ContainerRelativeShape().fill(Color.primaryColor))
            PrayerTimeLargeRow(prayerTime: entry.prayerTimes[0])
            if maxRows > 1 {
                Divider()
                PrayerTimeLargeRow(prayerTime: entry.prayerTimes[1])
            }
            if maxRows > 2 {
                Divider()
                PrayerTimeLargeRow(prayerTime: entry.prayerTimes[2])
            }
            if maxRows > 3 {
                Divider()
                PrayerTimeLargeRow(prayerTime: entry.prayerTimes[3])
            }
            if maxRows > 4 {
                Divider()
                PrayerTimeLargeRow(prayerTime: entry.prayerTimes[4])
            }
        }
        .padding(.vertical, 10)
    }
}

struct iSalahWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            iSalahWidgetEntryView(entry: iSalahEntry(date: Date(), prayerTimes: PrayerTime.samples, message: nil))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            iSalahWidgetEntryView(entry: iSalahEntry(date: Date(), prayerTimes: PrayerTime.samples, message: nil))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            iSalahWidgetEntryView(entry: iSalahEntry(date: Date(), prayerTimes: PrayerTime.samples, message: nil))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
