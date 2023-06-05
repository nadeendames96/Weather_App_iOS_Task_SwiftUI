//  ContentView.swift
//  Weather_App_Task
//  Created by Nadeen Dames on 04/06/2023.
import SwiftUI
import KRProgressHUD
struct SplashView: View {
    @State private var isShowMainScreen = false
    @StateObject private var splashViewModel = SplashViewModel()
    var body: some View {
        NavigationView {
            VStack {
                Image("weather")
                    .resizable()
                    .scaledToFit()
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                NavigationLink(destination: HomeView(), isActive: $isShowMainScreen) {
                    EmptyView()
                }
                .hidden()
            }.onAppear{
                splashViewModel.actualLocation()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    KRProgressHUD.show()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.isShowMainScreen = true
                        KRProgressHUD.dismiss()
                    }
                }
            }
            .padding()
            .background(Color.bgColor)
        }
    }
}

func loadingScreen(){
    KRProgressHUD.show()
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
