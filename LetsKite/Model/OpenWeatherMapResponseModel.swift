//
//  OpenWeatherMapResponseModel.swift
//  LetsKite
//
//  Created by Stephen Brundage on 6/4/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

struct OpenWeatherMapResponseModel: Codable {
    var list: [OpenWeatherMapItem]?
    var city: CityData?
}

public struct OpenWeatherMapItem: Codable {
    var main: Main
    var weather: [Weather]
    var wind: Wind
    var dt: Double
}

struct CityData: Codable {
    var id: Int
    var name: String
    var coord: Coordinates
    var country: String
    var population: Int
    var timezone: Double
    var sunrise: Double
    var sunset: Double
}

struct Coordinates: Codable {
    var lat: Float
    var lon: Float
}

struct Main: Codable {
    var temp: Float
    var feels_like: Float
    var temp_min: Float
    var temp_max: Float
    var humidity: Int
}

struct Weather: Codable {
    var main: String
    var description: String
}

struct Wind: Codable {
    var speed: Float
}
