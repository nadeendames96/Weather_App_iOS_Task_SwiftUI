//
//  Constant.swift
//  Weather_App_Task
//
//  Created by Nadeen Dames on 04/06/2023.
//

import Foundation
struct API{
    static let API_DOMAIN = "https://api.openweathermap.org/data/2.5/"
    static let API_Current_Weather_HOST = API_DOMAIN + "weather?"
    static let API_Daily_Weather_HOST = API_DOMAIN + "onecall?"
    static let API_Forecast_Weather_HOST = API_DOMAIN + "forecast?"
}

let API_KEY = "1c2ba745810db56a9f945361a2520a0a"
let DEFAULT_DAILRY_WEATHER_API = "https://api.openweathermap.org/data/2.5/onecall?lat=53.9024716&lon=27.5618225&"
let DEFAULT_CURRENT_WEATHER_API = "https://api.openweathermap.org/data/2.5/weather?lat=53.9024716&lon=27.5618225&"
let cornerRaduis = 10.0
