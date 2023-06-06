//
//  Helper.swift
//  Weather_App_Task
//
//  Created by Nadeen Dames on 06/06/2023.
//

import Foundation
import SwiftUI

func roundDoubleToInt(_ number:Double) -> Int {
    return Int(number.rounded())
}

func responsivePadding() -> EdgeInsets {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
        if horizontalSizeClass == .compact {
            // Apply smaller padding for compact horizontal size class
            return EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8)
        } else {
            // Apply larger padding for regular horizontal size class
            return EdgeInsets(top: 32, leading: 16, bottom: 32, trailing: 16)
        }
    }
func dateFormater(date: TimeInterval, dateFormat: String,timezone:Int) -> String {
    let dateText = Date(timeIntervalSince1970: date )
    let formater = DateFormatter()
    formater.timeZone = TimeZone(secondsFromGMT: timezone ?? 0)
    formater.dateFormat = dateFormat
    return formater.string(from: dateText)
}
