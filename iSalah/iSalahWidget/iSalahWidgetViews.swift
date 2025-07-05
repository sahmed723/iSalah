//
//  iSalahWidgetViews.swift
//  iSalahWidgetExtension
//
//  Created by Tharindu Perera on 11/18/20.
//  Copyright © 2020 Intelcy. All rights reserved.
//

import SwiftUI
import WidgetKit

struct SmallWidgetView : View {
    var entry: iSalahTimelineProvider.Entry
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                if entry.isPlaceholder {
                    Spacer()
                    Text("--:--")
                        .font(.getWidgetFont(size: 22, weight: .regular))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.55)
                    Spacer()
                } else {
                    if let displayablePrayerTime = entry.displayablePrayerTime.0 {
                        Spacer()
                        
                        let type = entry.displayablePrayerTime.1
                        
                        HStack {
                            Image("WidgetLogoImage")
                                .resizable()
                                .frame(width: 22, height: 22)
                                .unredacted()
                            Text("\(displayablePrayerTime.salah) \(type == .nextPrayerTime ? "in" : "")")
                                .font(.getWidgetFont(size: 22, weight: .regular))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.55)
                        }
                        
                        Spacer()

                        switch type {
                        case .currentPrayerTime:
                            Text("Now")
                                .font(.getWidgetFont(size: 22, weight: .semibold))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.55)
                            if let islamicDate = entry.islamicDate {
                                Spacer()
                                Text("\(islamicDate)")
                                    .font(.getWidgetFont(size: 18, weight: .regular))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                    .minimumScaleFactor(0.55)
                            }
                        case .nextPrayerTime:
                            Text(displayablePrayerTime.timeObject, style: .relative)
                                .font(.getTimerFont(size: 18))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .lineLimit(1)
                            if let islamicDate = entry.islamicDate {
                                Spacer()
                                Text("\(islamicDate)")
                                    .font(.getWidgetFont(size: 18, weight: .regular))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                    .minimumScaleFactor(0.55)
                            }
                        case .nextDayPrayerTime:
                            Text("Tomorrow")
                                .font(.getWidgetFont(size: 22, weight: .semibold))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.55)
                        }
                        Spacer()
                    }
                }
            }
            .padding(.vertical, 5)
            .frame(width: geo.size.width, height: geo.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
        .padding(5)
    }
}

struct MediumWidgetView : View {
    var entry: iSalahTimelineProvider.Entry
    
    var body: some View {
        HStack {
            ZStack {
                GeometryReader { geo in
                    VStack {
                        if entry.isPlaceholder {
                            Spacer()
                            Text("--:--")
                                .font(.getWidgetFont(size: 22, weight: .regular))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.55)
                            Spacer()
                        } else {
                            if let displayablePrayerTime = entry.displayablePrayerTime.0 {
                                Spacer()
                                
                                let type = entry.displayablePrayerTime.1
                                
                                HStack {
                                    Image("WidgetLogoImage")
                                        .resizable()
                                        .renderingMode(.template)
                                        .foregroundColor(.white)
                                        .frame(width: 22, height: 22)
                                        .unredacted()
                                    Text("\(displayablePrayerTime.salah) \(type == .nextPrayerTime ? "in" : "")")
                                        .font(.getWidgetFont(size: 22, weight: .regular))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .minimumScaleFactor(0.55)
                                }
                                
                                Spacer()

                                switch type {
                                case .currentPrayerTime:
                                    Text("Now")
                                        .font(.getWidgetFont(size: 22, weight: .semibold))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .minimumScaleFactor(0.55)
                                    if let islamicDate = entry.islamicDate {
                                        Spacer()
                                        Text("\(islamicDate)")
                                            .font(.getWidgetFont(size: 18, weight: .regular))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                            .minimumScaleFactor(0.55)
                                    }
                                case .nextPrayerTime:
                                    Text(displayablePrayerTime.timeObject, style: .relative)
                                        .font(.getTimerFont(size: 18))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(1)
                                    if let islamicDate = entry.islamicDate {
                                        Spacer()
                                        Text("\(islamicDate)")
                                            .font(.getWidgetFont(size: 18, weight: .regular))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                            .minimumScaleFactor(0.55)
                                    }
                                case .nextDayPrayerTime:
                                    Text("Tomorrow")
                                        .font(.getWidgetFont(size: 22, weight: .semibold))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .minimumScaleFactor(0.55)
                                }
                                Spacer()
                            }
                        }
                    }
                    .padding(.vertical, 5)
                    .frame(width: geo.size.width, height: geo.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                .padding(.vertical, 4)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(ContainerRelativeShape().fill(Color.primaryColor))
            
            VStack {
                let preferredMax = 5
                let maxRows = (entry.prayerTimes.count > preferredMax) ? preferredMax : entry.prayerTimes.count
                PrayerTimeHorizontalRow(prayerTime: entry.prayerTimes[0])
                    .padding(.bottom, 1)
                if maxRows > 1 {
                    PrayerTimeHorizontalRow(prayerTime: entry.prayerTimes[1])
                        .padding(.bottom, 1)
                }
                if maxRows > 2 {
                    PrayerTimeHorizontalRow(prayerTime: entry.prayerTimes[2])
                        .padding(.bottom, 1)
                }
                if maxRows > 3 {
                    PrayerTimeHorizontalRow(prayerTime: entry.prayerTimes[3])
                        .padding(.bottom, 1)
                }
                if maxRows > 4 {
                    PrayerTimeHorizontalRow(prayerTime: entry.prayerTimes[4])
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
        }
        .padding()
    }
}

struct LargeWidgetView : View {
    var entry: iSalahTimelineProvider.Entry
    
    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                HStack {
                    Spacer()
                    Text("\(entry.islamicDate ?? "N/A")")
                        .font(.getWidgetFont(size: 22, weight: .regular))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.55)
                    Spacer()
                }
                .padding(.vertical, 5)
                .background(ContainerRelativeShape().fill(Color.primaryColor))
            }
            .padding(.top, 4)
            .padding(.horizontal)
            
            HStack {
                ZStack {
                    VStack {
                        if entry.isPlaceholder {
                            Spacer()
                            Text("--:--")
                                .font(.getWidgetFont(size: 24, weight: .regular))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.55)
                            Spacer()
                        } else {
                            if let displayablePrayerTime = entry.displayablePrayerTime.0 {
                                Spacer()
                                
                                let type = entry.displayablePrayerTime.1
                                
                                Text("\(displayablePrayerTime.salah) \(type == .nextPrayerTime ? "in" : "")")
                                    .font(.getWidgetFont(size: 24, weight: .regular))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                    .minimumScaleFactor(0.55)

                                switch type {
                                case .currentPrayerTime:
                                    Text("Now")
                                        .font(.getWidgetFont(size: 24, weight: .semibold))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .minimumScaleFactor(0.55)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 2)
                                        .background(Color.primaryColor)
                                        .cornerRadius(5)
                                case .nextPrayerTime:
                                    Text(displayablePrayerTime.timeObject, style: .relative)
                                        .font(.getTimerFont(size: 18))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(1)
                                        .padding(.vertical, 2)
                                        .background(Color.primaryColor)
                                        .cornerRadius(5)
                                case .nextDayPrayerTime:
                                    Text("Tomorrow")
                                        .font(.getWidgetFont(size: 24, weight: .semibold))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .minimumScaleFactor(0.55)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 2)
                                        .background(Color.primaryColor)
                                        .cornerRadius(5)
                                }
                                Spacer()
                            }
                            
                            if let city = entry.city {
                                Text("\(city)")
                                    .font(.getWidgetFont(size: 24, weight: .regular))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                    .minimumScaleFactor(0.55)
                                Spacer()
                            }
                        }
                    }.padding(.vertical)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                
                VStack {
                    let preferredMax = 5
                    let maxRows = (entry.prayerTimes.count > preferredMax) ? preferredMax : entry.prayerTimes.count
                    PrayerTimeVerticalRow(prayerTime: entry.prayerTimes[0])
                    if maxRows > 1 {
                        Divider()
                        PrayerTimeVerticalRow(prayerTime: entry.prayerTimes[1])
                    }
                    if maxRows > 2 {
                        Divider()
                        PrayerTimeVerticalRow(prayerTime: entry.prayerTimes[2])
                    }
                    if maxRows > 3 {
                        Divider()
                        PrayerTimeVerticalRow(prayerTime: entry.prayerTimes[3])
                    }
                    if maxRows > 4 {
                        Divider()
                        PrayerTimeVerticalRow(prayerTime: entry.prayerTimes[4])
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            .padding(.horizontal)
        }.padding(.vertical, 7)
    }
}

struct iSalahWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            iSalahWidgetEntryView(entry: .stub)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            iSalahWidgetEntryView(entry: .stub)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            iSalahWidgetEntryView(entry: .stub)
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
