//
//  PrayerTimeLargeRow.swift
//  iSalah
//
//  Created by Tharindu Perera on 9/27/20.
//

import SwiftUI

struct PrayerTimeHorizontalRow: View {
    var prayerTime: PrayerTime

    var body: some View {
        HStack {
            HStack {
                Text(prayerTime.salah)
                    .font(.getWidgetFont(weight: .bold))
                    .foregroundColor(.primaryDarkColor)
                    .minimumScaleFactor(0.75)
                    .lineLimit(1)
                Spacer()
                Text(prayerTime.time)
                    .font(.getWidgetFont(size: 13.75))
                    .foregroundColor(.primaryDarkColor)
                    .minimumScaleFactor(0.75)
                    .lineLimit(1)
            }
            .padding(.leading, 5)
            .padding(.trailing, 4)
            .background(Color.clear)
        }
    }
}

struct PrayerTimeLargeRow_Previews: PreviewProvider {
    static var previews: some View {
        PrayerTimeHorizontalRow(prayerTime: PrayerTime.samples[0])
            .previewLayout(.fixed(width: 300, height: 50))
    }
}
