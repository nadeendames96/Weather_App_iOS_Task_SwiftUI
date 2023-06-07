//
//  SearchViewModel.swift
//  Weather_App_Task
//
//  Created by Nadeen Dames on 07/06/2023.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation

class SearchViewModel: NSObject,ObservableObject {
    @Published var searchText = ""
    @Published var searchResults: [CitesModelElement] = []
    @Published var isSelectCity = false
    @Published var weather = WeatherModel()
    private let locationManager = CLLocationManager()
    weak var delegate: SearchViewModelDelegate?
    private var data : [CitesModelElement]?
    private var cancellable: AnyCancellable?
    private var lat: Double = 0.0
    private var lon: Double = 0.0
    
    override init() {
        super.init()
        cancellable = $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] value in
                self?.performSearch()
            }
    }
    
    func performSearch() {
        self.data = CountriesCitiesImp.shared.cities
        if searchText.isEmpty {
            searchResults = []
        } else {
            searchResults = data!.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    func itemClicked(at item: CitesModelElement){
        self.isSelectCity = true
        if data!.isEmpty {
            if locationManager.authorizationStatus != .denied {
                self.delegate?.setLocation(self.lat ?? 0.0, self.lon ?? 0.0)
            }
        } else {
            self.delegate?.setLocation(Double(item.latitude ?? "") ?? 0.0,Double(item.longitude ?? "") ?? 0.0)
        }
    }
    
    func getCity(){
        self.actualLocation()
    }
}
extension SearchViewModel: CLLocationManagerDelegate {
    private func actualLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location?.coordinate else { return }
        lat = location.latitude
        lon = location.longitude
        locationManager.stopUpdatingLocation()
    }
}
