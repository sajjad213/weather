//
//  Date+Extension.swift
//  Weather
//
//  Created by Sajjad Khazraei on 10/29/23.
//

import Foundation

extension Date {
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM d, YYYY HH:MM a"
        return dateFormatter.string(from: self)
    }
    
    func forecastFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self)
    }
}
