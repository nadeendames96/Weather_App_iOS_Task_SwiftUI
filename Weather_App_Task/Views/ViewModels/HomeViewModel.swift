//
//  HomeViewModel.swift
//  Weather_App_Task
//
//  Created by Nadeen Dames on 05/06/2023.
//
import SwiftUI
import Combine
class HomeViewModel:ObservableObject{
    @Published var currentDay: String = ""
    @Published var currentDate: String = ""
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()
    
    private let fullDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d yyyy"
        return formatter
    }()
    
    init() {
        updateCurrentDate()
    }
    
    func updateCurrentDate() {
        let now = Date()
        currentDay = dateFormatter.string(from: now)
        currentDate = fullDateFormatter.string(from: now)
    }
}
