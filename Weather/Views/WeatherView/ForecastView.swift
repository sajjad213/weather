//
//  ForecastView.swift
//  Weather
//
//  Created by Sajjad Khazraei on 10/29/23.
//

import SwiftUI

struct ForecastView: View {
    let forecast: [Forecast]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Nex 5 Days")
                .font(.headline)
                .multilineTextAlignment(.leading)
            HStack {
                if forecast.isEmpty {
                    ProgressView()
                } else {
                    ForEach(forecast) { data in
                        ForecastItemView(data: data)
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .shadow(radius: 5, x: 0, y: 2)
            )
        }
        .padding(.vertical)
    }
}

struct ForecastItemView: View {
    let data: Forecast

    var body: some View {
        VStack {
            Text(data.dt.forecastFormattedDate())
                .font(.caption)
                .foregroundColor(.gray)
            AsyncImage(url: Images.owmIconUrl(for: data.icon)) { image in
                image
                    .resizable()
                    .frame(width: 48, height: 48)
            } placeholder: {
                ProgressView()
                    .frame(width: 48, height: 48)
            }
            Text("\(Int(data.temp))°C")
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

//#Preview {
//    LocationSearchView()
//}
