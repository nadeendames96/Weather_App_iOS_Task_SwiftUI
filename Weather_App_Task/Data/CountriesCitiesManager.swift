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
    func getCity(compelition: @escaping ([CitesModelElement ]) -> ()) {
           guard let path = Bundle.main.path(forResource: "cities", ofType: "json") else { return }
           do {
               let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
               let object = try JSONDecoder().decode([CitesModelElement].self, from: data)
               
               DispatchQueue.main.async {
                   compelition(object)
               }
           } catch {
               print("Can't parse cities \(error.localizedDescription)")
           }
       }
    
    func getCountry(compelition: @escaping ([CountryModel ]) -> ()) {
           guard let path = Bundle.main.path(forResource: "countries", ofType: "json") else { return }
           do {
               let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
               let object = try JSONDecoder().decode([CountryModel].self, from: data)
               
               DispatchQueue.main.async {
                   compelition(object)
               }
           } catch {
               print("Can't parse cities \(error.localizedDescription)")
           }
       }
}
