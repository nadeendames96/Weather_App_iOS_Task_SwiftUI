//
//  CountriesCitesImp.swift
//  Weather_App_Task
//
//  Created by Nadeen Dames on 05/06/2023.
//

import Foundation
class CountriesCitiesImp {
    var cities: [CountriesCiteModel]?
    static let shared = CountriesCitiesImp()
    private init () {}
    
    func getCity() {
       let queue = DispatchQueue(label: "CountriesCitiesImp")
       queue.async {
           CountriesCitiesManager.shared.getCountryCity { [weak self] newCity in
              self?.cities = newCity
          }
       }
    }
}
