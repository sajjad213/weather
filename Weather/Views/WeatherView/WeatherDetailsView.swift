//
//  WeatherDetailsView.swift
//  Weather
//
//  Created by Sajjad Khazraei on 10/29/23.
//

import SwiftUI

struct WeatherDetailsView: View {
    let currentWeather: CurrectWeather

    var body: some View {
        HStack {
            WeatherDetailItem(icon: Images.humidity, title: "Humidity", value: "\(currentWeather.humidity)%")
            WeatherDetailItem(icon: Images.wind, title: "Wind Speed", value: "\(currentWeather.windSpeed) m/s")
        }
        .padding(.vertical)
    }
}

struct WeatherDetailItem: View {
    let icon: Image
    let title: String
    let value: String

    var body: some View {
        HStack {
            icon
                .renderingMode(.template)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.blue)
            VStack(alignment: .leading) {
                Text(value)
                    .fontWeight(.bold)
                Text(title)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(radius: 5, x: 0, y: 2)
        )
    }
}

//#Preview {
//    WeatherForecastView()
//}
