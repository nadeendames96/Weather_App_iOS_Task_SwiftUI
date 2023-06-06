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
                            .foregroundColor(Color.weatherSkyColor)
                            .aspectRatio(1, contentMode: .fill)
                            .frame(width: min(geometry.size.width, geometry.size.height),
                                   height: min(geometry.size.width, geometry.size.height))
                            .overlay(
                                VStack(alignment: .center, spacing: 0){
                                    Spacer()
                                    Text(globalViewModel.countryState) .foregroundColor(.white)
                                        .font(CustomFont.LargeBoldFont)
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
                                    HStack {
                                        Circle()
                                            .foregroundColor(.white)
                                            .frame(width: 10, height: 10)
                                        
                                        Circle()
                                            .foregroundColor(.gray)
                                            .frame(width: 10, height: 10)
                                    }
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
                                                    .frame(width: 50, height: 50 )
                                                
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 50, height: 50 )
                                                
                                            case .failure(_):
                                                Image(systemName: "thermometer.sun.fill")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 50, height: 50 )
                                                
                                            @unknown default:
                                                EmptyView()
                                            }
                                        }
                                        
                                    }
                                    
                                    Text("\(globalViewModel.weatherCondition)").font(CustomFont.LargeBoldFont)
                                        .padding(.all)
                                        .padding(.top,20)
                                }
                            ).cornerRadius(cornerRaduis)
                        Spacer()
                        HourlyWeatherView()
                        Rectangle().frame(height: CGFloat(1))
                        Spacer()
                        HStack{
                            VStack{
                                Text("max_temp".LC())
                                    .padding(.all)
                                    .foregroundColor(Color.txtColor)
                                Text("\(globalViewModel.maxTemp)").font(CustomFont.LargeRegularFont).foregroundColor(Color.txtColor)
                                
                            }
                            Spacer()
                            
                            VStack{
                                Text("min_temp".LC())
                                    .padding(.all)
                                    .foregroundColor(Color.txtColor)
                                Text("\(globalViewModel.minTemp)").font(CustomFont.LargeRegularFont).foregroundColor(Color.txtColor)
                                
                                
                            }
                        }
                        Spacer()
                        HStack{
                            VStack{
                                Text("humidity".LC())
                                    .padding(.all)
                                    .foregroundColor(Color.txtColor)
                                Text("\(globalViewModel.humidityWeather)").font(CustomFont.LargeRegularFont).foregroundColor(Color.txtColor)
                                
                            }
                            Spacer()
                            
                            VStack{
                                Text("wind_speed".LC())
                                    .padding(.all)
                                    .foregroundColor(Color.txtColor)
                                Text("\(globalViewModel.windSpeedWeather)").font(CustomFont.LargeRegularFont).foregroundColor(Color.txtColor)
                                
                                
                            }
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
