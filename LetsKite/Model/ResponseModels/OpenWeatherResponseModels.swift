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

struct OpenWeatherMapData: Codable {
    var main: Main
    var weather: [Weather]
    var wind: Wind
    var dt_txt: String
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
