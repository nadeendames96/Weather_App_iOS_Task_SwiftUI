//  HomeView.swift
//  Weather_App_Task
//  Created by Nadeen Dames on 05/06/2023.

import SwiftUI
import Combine
struct HomeView: View {
    @State private var showSearchScreen = false
    var body: some View {
        NavigationView{
            GeometryReader{
                geometry in
                
                
            } .navigationBarItems(trailing:
                                    NavigationLink(destination: SearchView(), isActive: $showSearchScreen) {
                                        Image(systemName: "magnifyingglass")
                                            .imageScale(.large)
                                            .foregroundColor(.blue)
                                    }
                                )
        }.navigationBarBackButtonHidden()
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
