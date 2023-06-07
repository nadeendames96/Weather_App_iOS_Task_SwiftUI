//
//  Protocols.swift
//  Weather_App_Task
//
//  Created by Nadeen Dames on 07/06/2023.
//

import Foundation
protocol SearchViewModelDelegate: AnyObject {
    func setLocation(_ lat: Double, _ lon: Double)
}
