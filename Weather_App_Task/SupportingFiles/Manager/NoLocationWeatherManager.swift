//
//  NoLocationWeatherManager.swift
//  Weather_App_Task
//
//  Created by Nadeen Dames on 05/06/2023.
//

import Foundation
import KRProgressHUD
class NoLocationWeatherManager {
    static let shared = NoLocationWeatherManager()
    
    private init() {}
    
    func getCurrentWeather(lang: String, completion: @escaping (Result<CurrentWeather,NetworkError>) -> Void) {
        guard let url = URL(string: "\(DEFAULT_CURRENT_WEATHER_API)lang=\(lang)&units=metric&appid=\(API_KEY)") else {
            KRProgressHUD.showError(withMessage: "finished with error [-1003] Error Domain=NSURLErrorDomain Code=-1003 A server with the specified hostname could not be found.")
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
    
    func getDailyWeather(lang: String, completion: @escaping (Result<DailyWeather,NetworkError>) -> Void) {
        guard let url = URL(string: "\(DEFAULT_DAILRY_WEATHER_API)lang=\(lang)&exclude=minutely&units=metric&appid=\(API_KEY)") else {
            KRProgressHUD.showError(withMessage: "finished with error [-1003] Error Domain=NSURLErrorDomain Code=-1003 A server with the specified hostname could not be found.")
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
    
}
