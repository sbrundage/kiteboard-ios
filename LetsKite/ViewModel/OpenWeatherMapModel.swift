//
//  OpenWeatherMapModel.swift
//  LetsKite
//
//  Created by Stephen Brundage on 5/25/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

struct WindOutlookViewModel {
    var dayViews: [DayViewModel]
}

struct DayViewModel {
    var hourlyViews: [HourViewModel] = []
    var dateModel: CustomDate
}

struct HourViewModel {
    var weather: String
    var temp: Float
    var windSpeed: Float
    var dateModel: CustomDate
}

public struct CustomDate: Comparable, Hashable {
    
    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()
    
    let date: Date
    let dateString: String
    let unixTime: Double
    let timeZone: Double
    
    init(unixTime: Double, timeZone: Double) {
        self.unixTime = unixTime
        self.timeZone = timeZone
        self.date = Date(timeIntervalSince1970: (unixTime + timeZone))
        self.dateString = Self.dateFormatter.string(from: date)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(dateString)
    }
    
    public static func < (lhs: CustomDate, rhs: CustomDate) -> Bool {
        return lhs.date < rhs.date
    }
    
    public static func == (lhs: CustomDate, rhs: CustomDate) -> Bool {
        return lhs.dateString == rhs.dateString
    }
}
