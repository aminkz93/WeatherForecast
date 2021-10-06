//
//  WeatherData.swift
//  WeatherForecast
//
//  Created by Amin on 2021-10-04.
//

import Foundation

struct WeatherData: Codable {
    let daily: [Daily]
    let hourly: [Hourly]
}

struct Hourly: Codable {
    let dt: TimeInterval
    let temp: Double
}

struct Daily: Codable {
    let dt: TimeInterval
    let temp: Temp
    let weather: [Weather]
}

struct Weather: Codable {
    let id: Int
    let main: String
}

struct Temp: Codable {
    let min: Double
    let max: Double
    
}


