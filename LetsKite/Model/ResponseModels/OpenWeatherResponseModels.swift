//
//  OpenWeatherMapModels.swift
//  LetsKite
//
//  Created by Stephen Brundage on 5/25/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

struct OpenWeatherMapResponseModel: Codable {
    var list: [OpenWeatherMapData] = []
}

public struct OpenWeatherMapData: Codable {
    var main: Main
    var weather: [Weather]
    var wind: Wind
    var dt: Double
    
    var date: Date {
        return Date(timeIntervalSince1970: dt)
    }
}

struct Main: Codable {
    var temp: Float
}

struct Weather: Codable {
    var main: String
    var description: String
}

struct Wind: Codable {
    var speed: Float
}
