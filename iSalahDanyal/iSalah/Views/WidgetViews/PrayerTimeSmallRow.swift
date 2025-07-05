//
//  PrayerTimeSmallRow.swift
//  iSalah
//
//  Created by Tharindu Perera on 9/27/20.
//

import SwiftUI

struct PrayerTimeSmallRow: View {
    var prayerTime: PrayerTime

    var body: some View {
        HStack {
            Image("WidgetLogoImage")
                .resizable()
                .frame(width: 22, height: 22)
                .padding(.leading)
            VStack(alignment: .leading) {
                HStack {
                    Text(prayerTime.salah)
                        .font(.getWidgetFont(weight: .bold))
                        .foregroundColor(.primaryDarkColor)
                        .minimumScaleFactor(0.75)
                    Spacer()
                }
                HStack {
                    Text(prayerTime.time)
                        .font(.getWidgetFont(size: 13.75))
                        .foregroundColor(.primaryDarkColor)
                        .minimumScaleFactor(0.75)
                    Spacer()
                }
            }
            .padding(.leading, 5)
            .padding(.trailing, 4)
            .background(Color.clear)
        }
    }
}

struct PrayerTimeSmallRow_Previews: PreviewProvider {
    static var previews: some View {
        PrayerTimeSmallRow(prayerTime: PrayerTime.samples[0])
            .previewLayout(.fixed(width: 180, height: 50))
    }
}
