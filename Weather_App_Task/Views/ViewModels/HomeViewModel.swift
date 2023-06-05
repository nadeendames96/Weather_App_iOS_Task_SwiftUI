//
//  HomeViewModel.swift
//  Weather_App_Task
//
//  Created by Nadeen Dames on 05/06/2023.
//

import Combine
class HomeViewModel:ObservableObject{
   @Published var weather = WeatherModel()

}
