//
//  globalEXT.swift
//  Weather_App_Task
//
//  Created by Nadeen Dames on 06/06/2023.
//

import Foundation
extension Double {
    func formatToTwoDigitsPrec() -> String {
        return String(format: "%.2f", self) + " " + "%"
    }
    func formatToTwoDigitsCe() -> String {
        return String(format: "%.2f", self) + " " + "C"
    }
    func formatToTwoDigits() -> String {
        return String(format: "%.2f", self)
    }
}



