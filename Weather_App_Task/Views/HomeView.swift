//  HomeView.swift
//  Weather_App_Task
//  Created by Nadeen Dames on 05/06/2023.

import SwiftUI
import Combine
struct HomeView: View {
    @StateObject private var globalViewModel = GlobalViewModel()
    @StateObject private var homeViewModel = HomeViewModel()
    var body: some View {
        NavigationView{
            GeometryReader{
                geometry in
                ScrollView{
                    VStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .background(
                                Image("\(globalViewModel.iconWeather)-2")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            )
                            .aspectRatio(1, contentMode: .fill)
                            .frame(width: min(geometry.size.width, geometry.size.height),
                                   height: min(geometry.size.width, geometry.size.height))
                            .overlay(
                                VStack(alignment: .center, spacing: 0){
                                    HStack(){
                                        Text(verbatim: homeViewModel.currentDay)
                                            .foregroundColor(.white)
                                            .frame(alignment: .leading)
                                            .font(CustomFont.MeduimRegularFont)
                                        Text(verbatim: homeViewModel.currentDate)
                                            .foregroundColor(.white)
                                            .frame(alignment: .leading)
                                            .font(CustomFont.MeduimRegularFont)
                                    }
                                    .padding(.all)
                                    .padding(.top,20)
                                    HStack{
                                        ZStack(alignment: .trailing){
                                            Circle()
                                                .stroke(Color.white)
                                                .frame(width: 10, height: 10)
                                                .scaledToFit()
                                            Text("\(globalViewModel.currentWeather)").font(CustomFont.ExtraBoldFont)
                                                .foregroundColor(.white)
                                                .padding(.all)
                                                .padding(.top,20)
                                        }
                                        AsyncImage(url: URL(string: globalViewModel.iconWithHost)) { phase in
                                            switch phase {
                                            case .empty:
                                                Image(systemName: "thermometer.sun.fill")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 35, height: 35 )
                                                
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 35, height: 35 )
                                                
                                            case .failure(_):
                                                Image(systemName: "thermometer.sun.fill")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 35, height: 35 )
                                                
                                            @unknown default:
                                                EmptyView()
                                            }
                                        }
                                        
                                    }.padding(.top,-60)
                                    Text("\(globalViewModel.countryState)").font(CustomFont.LargeBoldFont)
                                        .padding(.top,-30)
                                    Text("\(globalViewModel.weatherCondition)").font(CustomFont.LargeBoldFont)
                                        .padding(.top,-10)
                                        .padding(.bottom,20)
                                }
                                    .background(Color.black.opacity(0.5))
                                    .cornerRadius(50)
                                    .padding(.top,100)
                                    .padding(.all)
                            ).cornerRadius(cornerRaduis)
                        
                        Spacer()
                        if !globalViewModel.dataHourly.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(globalViewModel.dataHourly ?? []) { weather in
                                        VStack(alignment: .center) {
                                            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.weather.first?.icon).png")) { phase in
                                                switch phase {
                                                case .success(let image):
                                                    image
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 35, height: 35 )
                                                    
                                                @unknown default:
                                                    EmptyView()
                                                }
                                            }
                                            Text("\(weather.temp.formatToTwoDigits())").font(CustomFont.MeduimRegularFont)
                                                .foregroundColor(Color.txtColor)
                                            
                                            Text(verbatim: "\(dateFormater(date: weather.dt, dateFormat: "E d MMM",timezone: globalViewModel.weather.currentWeather!.timezone))").font(CustomFont.MeduimRegularFont)
                                                .foregroundColor(Color.txtColor)
                                        }
                                    }
                                }
                                .padding()
                            }
                        }
                        Spacer()
                        HStack{
                            VStack{
                                Text("max_temp".LC())
                                    .foregroundColor(Color.txtColor)
                                Text("\(globalViewModel.maxTemp)").font(CustomFont.LargeRegularFont).foregroundColor(Color.txtColor)
                                
                            }
                            Spacer()
                            
                            VStack{
                                Text("min_temp".LC())
                                    .foregroundColor(Color.txtColor)
                                Text("\(globalViewModel.minTemp)").font(CustomFont.LargeRegularFont).foregroundColor(Color.txtColor)
                                
                                
                            }
                        }.padding(.leading,10)
                            .padding(.trailing,10)
                        
                        HStack{
                            VStack{
                                Text("pressure".LC())
                                    .foregroundColor(Color.txtColor)
                                Text("\(globalViewModel.pressure)").font(CustomFont.LargeRegularFont).foregroundColor(Color.txtColor)
                            }
                        }
                        HStack{
                            VStack{
                                Text("humidity".LC())
                                    .foregroundColor(Color.txtColor)
                                Text("\(globalViewModel.humidityWeather)").font(CustomFont.LargeRegularFont).foregroundColor(Color.txtColor)
                            }
                            Spacer()
                            VStack{
                                Text("wind_speed".LC())
                                    .foregroundColor(Color.txtColor)
                                Text("\(globalViewModel.windSpeedWeather)").font(CustomFont.LargeRegularFont).foregroundColor(Color.txtColor)
                                
                                
                            }
                        }.padding(.leading,10)
                            .padding(.trailing,10)
                        
                        if !globalViewModel.dataDaily.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(globalViewModel.dataDaily ?? []) { weather in
                                        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.weather.first?.icon).png")) { phase in
                                            switch phase {
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 35, height: 35 )
                                                
                                            @unknown default:
                                                EmptyView()
                                            }
                                        }
                                        Text(verbatim: "\(dateFormater(date: weather.dt, dateFormat: "E d MMM",timezone: globalViewModel.weather.currentWeather!.timezone))").font(CustomFont.MeduimRegularFont)
                                            .foregroundColor(Color.txtColor)
                                        Text(verbatim: "\(weather.temp.day.formatToTwoDigitsCe())").font(CustomFont.MeduimRegularFont)
                                            .foregroundColor(Color.txtColor)
                                        Spacer()
                                    }
                                  
                                }.background(.yellow.opacity(0.5))
                            }
                            .padding()
                        }
                    }
                }.onAppear{
                    globalViewModel.checkNetwork()
                }
                .ignoresSafeArea(.all)
                
                
            }.navigationBarItems(trailing:
                                    NavigationLink(destination: SearchView()) {
                Image(systemName: "location.magnifyingglass")
                    .imageScale(.large)
                    .foregroundColor(.white)
            }
            )
            .navigationBarItems(leading:
                                    NavigationLink(destination: NotificationsView()) {
                Image(systemName: "bell.fill")
                    .imageScale(.large)
                    .foregroundColor(.white)
            }
            )
            .navigationBarTitleDisplayMode(.large)
            .navigationBarTitle("\(globalViewModel.locationName)").font(CustomFont.LargeBoldFont).foregroundColor(Color.white)
        }.navigationBarBackButtonHidden()
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
