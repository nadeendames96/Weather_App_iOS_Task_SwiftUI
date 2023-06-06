//  SplashViewModel.swift
//  Weather_App_Task
//
//  Created by Nadeen Dames on 05/06/2023.

import Combine
import Foundation
import CoreLocation
import KRProgressHUD
import Network
class GlobalViewModel : NSObject, ObservableObject{
    @Published var weather = WeatherModel()
    @Published var locationName = ""
    @Published var currentWeather = 0
    @Published var weatherCondition = ""
    @Published var iconWeather = ""
    @Published var iconWithHost = ""
    @Published var iconDialyWithHost = ""
    @Published var dataHourly = [Current]()
    @Published var dataDaily = [Daily]()
    @Published var humidityWeather = ""
    @Published var windSpeedWeather = ""
    @Published var countryState = ""
    @Published var maxTemp = ""
    @Published var minTemp = ""
    @Published var feels_like = ""
    @Published var pressure = ""
    @Published var testTemp = 0
    
    @Published var isGeolocationWeather = false
    private let monitor = NWPathMonitor()
    private let locationManager = CLLocationManager()
    private func getWeather() {
        if weather.lat != nil && weather.lon != nil {
            self.weather.withGeolocationWeather {
                self.isGeolocationWeather = true
                if self.weather.dailyWeather == nil{
                    KRProgressHUD.showError(withMessage: "A server with the specified hostname could not be found.")
                }
                else{
                    self.dataHourly = self.weather.dailyWeather?.hourly ?? []
                    self.dataDaily = self.weather.dailyWeather?.daily ?? []
                }
                if self.weather.currentWeather == nil{
                    KRProgressHUD.showError(withMessage: "A server with the specified hostname could not be found.")
                }
                else{
                    self.locationName = self.weather.currentWeather?.name ?? ""
                    self.currentWeather = roundDoubleToInt(self.weather.currentWeather?.main.temp ?? 0.0)
                    self.weatherCondition = self.weather.currentWeather?.weather.first?.description.capitalized ?? ""
                    self.iconWeather = "\(self.weather.currentWeather?.weather.first?.icon ?? "")"
                    self.iconWithHost = "https://openweathermap.org/img/wn/\(self.iconWeather).png"
                    self.humidityWeather = self.weather.currentWeather?.main.humidity.formatToTwoDigitsPrec() ?? "0.0"
                    self.windSpeedWeather = self.weather.currentWeather?.wind.speed.formatToTwoDigitsPrec() ?? "0.0"
                    self.countryState = self.weather.currentWeather?.sys.country ?? ""
                    self.maxTemp = self.weather.currentWeather?.main.temp_max.formatToTwoDigitsCe() ?? ""
                    self.minTemp = self.weather.currentWeather?.main.temp_min.formatToTwoDigitsCe() ?? ""
                    self.pressure = self.weather.currentWeather?.main.feels_like.formatToTwoDigitsPrec() ?? ""
                }

            }
        } else {
            self.weather.noGeolocationWeather {
                if self.weather.currentWeather == nil{
                    KRProgressHUD.showError(withMessage: "A server with the specified hostname could not be found.")
                }
                else{
                    self.isGeolocationWeather = false
                    self.locationName = self.weather.currentWeather?.name ?? ""
                    self.currentWeather = roundDoubleToInt(self.weather.currentWeather?.main.temp ?? 0.0)
                    self.weatherCondition = self.weather.currentWeather?.weather.first?.description.capitalized ?? ""
                    self.iconWeather = "\(self.weather.currentWeather?.weather.first?.icon)"
                    self.iconWithHost = "https://openweathermap.org/img/wn/\(self.iconWeather).png"
                    self.dataHourly = self.weather.dailyWeather?.hourly ?? []
                    self.humidityWeather = self.weather.currentWeather?.main.humidity.formatToTwoDigitsPrec() ?? "0.0 %"
                    self.windSpeedWeather = self.weather.currentWeather?.wind.speed.formatToTwoDigitsPrec() ?? "0.0"
                    self.countryState = self.weather.currentWeather?.sys.country ?? ""
                    self.maxTemp = self.weather.currentWeather?.main.temp_max.formatToTwoDigitsCe() ?? ""
                    self.minTemp = self.weather.currentWeather?.main.temp_min.formatToTwoDigitsCe() ?? ""
                    self.pressure = self.weather.currentWeather?.main.feels_like.formatToTwoDigitsPrec() ?? ""

                }
            }
        }
    }
    
    
    private func saveLocation(_ location: CLLocationCoordinate2D ) {
        weather.lat = location.latitude
        weather.lon = location.longitude
    }
}

extension GlobalViewModel:  CLLocationManagerDelegate  {
    func actualLocation() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location?.coordinate else { return }
        weather.lat = location.latitude
        weather.lon = location.longitude
        locationManager.stopUpdatingLocation()
        getWeather()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                getWeather()
                debugPrint("No access")
            case .authorizedAlways, .authorizedWhenInUse:
                debugPrint("Access")
            @unknown default:
                break
            }
        } else {
            debugPrint("Location services are not enabled")
        }
    }
    func checkNetwork(){
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.actualLocation()
                if self.locationManager.authorizationStatus == .denied {
                    self.getWeather()
                }
            } else {
                DispatchQueue.main.async {
                    KRProgressHUD.showMessage("\(path.status)")
                }
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
    }
}

