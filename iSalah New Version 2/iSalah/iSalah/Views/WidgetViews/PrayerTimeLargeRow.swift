//
//  PrayerTimeLargeRow.swift
//  iSalah
//
//  Created on 9/27/20.
//

import SwiftUI

struct PrayerTimeLargeRow: View {
    var prayerTime: PrayerTime

    var body: some View {
        HStack {
            Image("WidgetLogoImage")
                .resizable()
                .frame(width: 22, height: 22)
                .padding(.leading, 20)
            VStack(alignment: .leading) {
                HStack {
                    Text(prayerTime.salah)
                        .font(.getWidgetFont(weight: .bold))
                        .bold()
                        .foregroundColor(.primaryDarkColor)
                        .minimumScaleFactor(0.7)
                    Spacer()
                }
                HStack {
                    Text("Time: \(prayerTime.time)")
                        .font(.getWidgetFont(size: 13.75))
                        .foregroundColor(.primaryDarkColor)
                        .minimumScaleFactor(0.75)
                    Spacer()
                }
            }
            .padding(.leading, 5)
            .background(Color.clear)
        }
    }
}

struct PrayerTimeLargeRow_Previews: PreviewProvider {
    static var previews: some View {
        PrayerTimeLargeRow(prayerTime: PrayerTime.samples[0])
            .previewLayout(.fixed(width: 300, height: 50))
    }
}
