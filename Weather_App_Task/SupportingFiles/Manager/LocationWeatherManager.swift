//  LocationWeatherManager.swift
//  Weather_App_Task
//  Created by Nadeen Dames on 05/06/2023.

import Foundation
import KRProgressHUD
class LocationWeatherManager {
    static let shared = LocationWeatherManager()
    private init() {}
    func getCurrentWeather(lat:Double,lon:Double,locale: String,completion: @escaping (Result<CurrentWeather,NetworkError>) -> Void) {
        guard let url = URL(string: "\(API.API_Current_Weather_HOST)lat=\(lat)&lon=\(lon)&lang=\(locale)&units=metric&appid=\(API_KEY)") else {
            completion(.failure(.serverError))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                KRProgressHUD.showError(withMessage: error?.localizedDescription)
                completion(.failure(.serverError))
                return
            }
            do {
                let weather = try JSONDecoder().decode(CurrentWeather.self, from: data)
                completion(.success(weather))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
        
    }
    
    func getDailyWeather(lat:Double,lon:Double,locale: String, completion: @escaping (Result<DailyWeather,NetworkError>) -> ()) {
        
        guard let url = URL(string: "\(API.API_Daily_Weather_HOST)lat=\(lat)&lon=\(lon)&exclude=minutely&units=metric&appid=\(API_KEY)") else {
            completion(.failure(.serverError))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                KRProgressHUD.showError(withMessage: error?.localizedDescription)
                completion(.failure(.serverError))
                return
            }
            do {
                let weather = try JSONDecoder().decode(DailyWeather.self, from: data)
                completion(.success(weather))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    
    func getForecastWeather(lat:Double,lon:Double,locale: String, completion: @escaping (Result<DailyWeather,NetworkError>) -> ()) {
        
        guard let url = URL(string: "\(API.API_Daily_Weather_HOST)lat=\(lat)&lon=\(lon)&exclude=minutely&units=metric&appid=\(API_KEY)") else {
            completion(.failure(.serverError))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.serverError))
                return
            }
            do {
                let weather = try JSONDecoder().decode(DailyWeather.self, from: data)
                completion(.success(weather))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}






