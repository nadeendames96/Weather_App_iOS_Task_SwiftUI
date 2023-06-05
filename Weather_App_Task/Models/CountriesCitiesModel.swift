//
//  CountriesCitiesModel.swift
//  Weather_App_Task
//
//  Created by Nadeen Dames on 05/06/2023.
//

import Foundation


// MARK: - CountriesCite
struct CountriesCiteModel: Codable {
    let id: Int
    let name, iso3, iso2, phoneCode: String
    let capital, currency, currencySymbol, tld: String
    let native, region, subregion: String
    let timezones: [Timezone]
    let translations: Translations
    let latitude, longitude, emoji, emojiU: String
    let cities: [City]

    enum CodingKeys: String, CodingKey {
        case id, name, iso3, iso2
        case phoneCode = "phone_code"
        case capital, currency
        case currencySymbol = "currency_symbol"
        case tld, native, region, subregion, timezones, translations, latitude, longitude, emoji, emojiU, cities
    }
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name, latitude, longitude: String
}

// MARK: - Timezone
struct Timezone: Codable {
    let zoneName: String
    let gmtOffset: Int
    let gmtOffsetName, abbreviation, tzName: String
}

// MARK: - Translations
struct Translations: Codable {
    let kr, br, pt, nl: String
    let hr, fa, de, es: String
    let fr, ja, it, cn: String
}

typealias CountriesCites = [CountriesCiteModel]
