//  SearchView.swift
//  Weather_App_Task
//  Created by Nadeen Dames on 05/06/2023.

import SwiftUI
struct SearchView: View {
    @ObservedObject private var searchViewModel = SearchViewModel()
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView{
            VStack {
                SearchBar(text: $searchViewModel.searchText)
                    .padding()
                List(searchViewModel.searchResults) { item in
                    Text(item.name)
                        .font(CustomFont.MeduimRegularFont)
                        .foregroundColor(Color.txtColor)
                        .onTapGesture {
                            searchViewModel.itemClicked(at: item)
                            presentation.wrappedValue.dismiss()
                        }
                }
            }.onAppear{
                searchViewModel.getCity()
            }
        }
    }
}



struct SearchBar: View {
    @Binding var text: String
    var body: some View {
        ZStack(alignment: .trailing) {
            TextField("Search", text: $text).font(CustomFont.MeduimRegularFont).foregroundColor(Color.txtColor)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 8)
                .overlay(
                    HStack {
                        if !text.isEmpty {
                            Button(action: {
                                text = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing,20)
                            }
                        }
                    }
                )
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.trailing, 16)
        }.cornerRadius(cornerRaduis)
    }
}

