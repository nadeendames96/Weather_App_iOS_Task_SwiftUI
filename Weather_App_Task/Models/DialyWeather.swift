//
//  DialyWeather.swift
//  Weather_App_Task
//
//  Created by Nadeen Dames on 05/06/2023.
//

//import Foundation
//class DailyWeather: Codable {
//    let lat,lon: Double
//    let hourly: [Hourly]
//    let daily: [Daily]
//    let current: Hourly
//}
//
//
//class Daily: Codable {
//    let dt: TimeInterval
//    let weather: [WeatherIcon]
//    let temp: Temp
//}
//
//class Hourly: Codable,Identifiable {
//    var id :Int = 0
//    let dt: TimeInterval
//    let weather: [WeatherIcon]
//    let temp: Double
//
//}
//
//class WeatherIcon: Codable {
//    let icon: String
//}
//
//class Temp: Codable {
//    let min: Double
//    let max: Double
//}
//
//

import Foundation

// MARK: - DailyWeather
struct DailyWeather: Codable {
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: Hourly
    let hourly: [Hourly]
    let daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, hourly, daily
    }
}

// MARK: - Current
struct Hourly: Codable,Identifiable {
    let id: Int = 0
    let dt: Int
    let sunrise, sunset: Int?
    let temp, feelsLike: Double
    let pressure, humidity: Int
    let dewPoint, uvi: Double
    let clouds, visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double
    let weather: [WeatherDialy]
    let pop: Double?

}

// MARK: - Weather
struct WeatherDialy: Codable {
    let id: Int
    let main: MainWeather
    let description: Description
    let icon: String
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}

enum MainWeather: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
}

// MARK: - Daily
struct Daily: Codable {
    let dt, sunrise, sunset, moonrise: Int
    let moonset: Int
    let moonPhase: Double
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure, humidity: Int
    let dewPoint, windSpeed: Double
    let windDeg: Int
    let windGust: Double
    let weather: [Weather]
    let clouds: Int
    let pop, uvi: Double

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, clouds, pop, uvi
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let day, night, eve, morn: Double
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}
