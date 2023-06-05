//
//  SplashViewModel.swift
//  Weather_App_Task
//
//  Created by Nadeen Dames on 05/06/2023.
//

import Combine
import Foundation
import CoreLocation

class SplashViewModel : NSObject, ObservableObject{
    @Published var weather = WeatherModel()
    private let locationManager = CLLocationManager()
    func getWeather(compelition: @escaping () -> ()) {
        if weather.lat != nil && weather.lon != nil {
            weather.withGeolocationWeather {
                compelition()
            }
        } else {
            weather.noGeolocationWeather {
                compelition()
            }
        }
    }
    
    private func saveLocation(_ location: CLLocationCoordinate2D ) {
        weather.lat = location.latitude
        weather.lon = location.longitude
    }
}
extension SplashViewModel:  CLLocationManagerDelegate  {
    func 	actualLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location?.coordinate else { return }
        saveLocation(location)
        locationManager.stopUpdatingLocation()
    }
}
