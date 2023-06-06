//
//  CiteisModel.swift
//  Weather_App_Task
//
//  Created by Nadeen Dames on 06/06/2023.
//

import Foundation
// MARK: - CitesModelElement
struct CitesModelElement: Codable {
    let id: Int
    let name: String
    let stateID: Int
    let stateCode: String
    let countryID: Int
    let countryCode, latitude, longitude: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case stateID = "state_id"
        case stateCode = "state_code"
        case countryID = "country_id"
        case countryCode = "country_code"
        case latitude, longitude
    }
}

typealias CitesModel = [CitesModelElement]
