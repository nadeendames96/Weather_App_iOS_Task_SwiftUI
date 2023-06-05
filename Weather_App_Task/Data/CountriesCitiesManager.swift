//
//  CityManager.swift
//  Weather_App_Task
//
//  Created by Nadeen Dames on 05/06/2023.
//

import Foundation
class CountriesCitiesManager {
    static let shared = CountriesCitiesManager()
    private init () {}
    func getCountryCity(compelition: @escaping ([CountriesCiteModel]) -> ()) {
        guard let path = Bundle.main.path(forResource: "countriescities", ofType: "json") else { return }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let object = try JSONDecoder().decode([CountriesCiteModel].self, from: data)
            DispatchQueue.main.async {
                compelition(object)
            }
        } catch {
            print("Can't parse cities \(error.localizedDescription)")
        }
    }
}
