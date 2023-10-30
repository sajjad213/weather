//
//  WeatherLocationHeader.swift
//  Weather
//
//  Created by Sajjad Khazraei on 10/29/23.
//

import SwiftUI

struct WeatherLocationHeader: View {
    @Binding var location: String
    let currentWeather: CurrectWeather

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Images.location
                Text(location)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            Text(currentWeather.dt.formattedDate())
                .font(.caption)
                .foregroundColor(.gray)
            HStack {
                AsyncImage(url: Images.owmIconUrl(for: currentWeather.icon)) { image in
                    image
                        .resizable()
                        .frame(width: 100, height: 100)
                } placeholder: {
                    ProgressView()
                        .frame(width: 100, height: 100)
                }
                Text("\(Int(currentWeather.temp))°C")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
            }
            .padding()
            Text(currentWeather.weather.capitalized)
                .font(.subheadline)
                .fontWeight(.bold)
        }
        .padding(.top)
        .padding()
    }
}

//#Preview {
//    WeatherDetailView()
//}
