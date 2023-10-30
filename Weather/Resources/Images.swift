//
//  Images.swift
//  Weather
//
//  Created by Sajjad Khazraei on 10/29/23.
//

import SwiftUI

struct Images {
    static let location: Image = Image("location")
    static let humidity: Image = Image("humidity")
    static let wind: Image = Image("wind")
    
    static func owmIconUrl(for icon: String) -> URL? {
        URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
    }
}

