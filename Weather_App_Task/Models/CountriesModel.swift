//
//  CountriesModel.swift
//  Weather_App_Task
//
//  Created by Nadeen Dames on 07/06/2023.
//

import Foundation
// MARK: - Country
struct CountryModel: Codable {
    let id: Int
    let name, iso3, iso2, phoneCode: String
    let capital, currency, currencySymbol, tld: String
    let native: String?
    let region: Region
    let subregion: String
    let timezones: [Timezone]
    let translations: Translations
    let latitude, longitude, emoji, emojiU: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, iso3, iso2
        case phoneCode = "phone_code"
        case capital, currency
        case currencySymbol = "currency_symbol"
        case tld, native, region, subregion, timezones, translations, latitude, longitude, emoji, emojiU
    }
}

enum Region: String, Codable {
    case africa = "Africa"
    case americas = "Americas"
    case asia = "Asia"
    case empty = ""
    case europe = "Europe"
    case oceania = "Oceania"
    case polar = "Polar"
}
typealias Countries = [CountryModel]
