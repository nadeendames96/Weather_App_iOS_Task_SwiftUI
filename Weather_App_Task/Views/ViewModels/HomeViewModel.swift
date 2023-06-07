//
//  HomeViewModel.swift
//  Weather_App_Task
//
//  Created by Nadeen Dames on 05/06/2023.
//
import SwiftUI
import Combine
import CoreLocation
class HomeViewModel:ObservableObject{
    @Published var currentDay: String = ""
    @Published var currentDate: String = ""
    @Published var isNightMode = false
    @Published var selectedLanguage: LanguageModel
    private let locationManager = CLLocationManager()
    var setLanguages: [LanguageModel] = [
        LanguageModel(code: "en", name: "English"),
        LanguageModel(code: "ar", name: "Arabic"),
    ]
    
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
        selectedLanguage = LanguageModel(code: "en", name: "English")
        updateCurrentDate()
    }
    
    func updateCurrentDate() {
        let now = Date()
        currentDay = dateFormatter.string(from: now)
        currentDate = fullDateFormatter.string(from: now)
    }
    
    func toggleNightMode() {
        isNightMode.toggle()
        updateAppTheme()
    }
    
    private func updateAppTheme() {
        if isNightMode {
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
        } else {
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
        }
    }
    func changeLanguage(to currentLanguage: String) {
        if let selectedLanguage = setLanguages.first(where: { $0.code == currentLanguage }) {
            self.selectedLanguage = selectedLanguage
            updateAppLanguage()
        }
    }
    
    private func updateAppLanguage() {
        DispatchQueue.main.async {
            UserDefaults.standard.set([self.selectedLanguage.code], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: SplashView())
        }
    }
    
    func expCurrentLanguage(_ expLanguage: String) -> String{
        guard let currentLanguage = Bundle.main.preferredLocalizations.first else {
            return ""
        }
        return expLanguage == currentLanguage ?  expLanguage :  currentLanguage
    }
}
