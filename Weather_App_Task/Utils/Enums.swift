//
//  Enums.swift
//  Weather_App_Task
//
//  Created by Nadeen Dames on 05/06/2023.
//

import Foundation
enum SelectedViews {
    case splash
    case home
    case login
}

enum NetworkError: Error {
    case serverError
    case decodingError
}
