//
//  PersonListView.swift
//  ProjectFaker4
//
//  Created by Quentin Courrier on 9/13/24.
//

import Foundation
import SwiftUI


struct PersonListView: View {
    @ObservedObject var viewModel: PersonListViewModel
    @StateObject private var themeManager = ThemeManager()
    @State private var isLoading = true
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                if isLoading {
                    LoadingPage()
                } else {
                    VStack {
                        SearchBar(text: $searchText)
                        
                        List(viewModel.filteredPeople(searchText: searchText)) { person in
                            VStack(alignment: .leading, spacing: 10) {
                                Text("\(person.firstname) \(person.lastname), \(person.gender)")
                                    .font(.headline)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Adresse: \(person.address.street), \(person.address.city), \(person.address.country)")
                                        .font(.subheadline)
                                    
                                    Text("Code postal: \(person.address.zipcode)")
                                        .font(.subheadline)
                                }
                                
                                NavigationLink(destination: CreditCardListView(viewModel: CCListViewModel()).environmentObject(themeManager)) {
                                    Image(systemName: "arrow.right.circle")
                                        .imageScale(.large)
                                        .foregroundColor(.primary)
                                }
                                
                                AsyncImage(url: URL(string: person.image)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 100)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            .padding(.vertical, 10)
                        }
                    }
                    .navigationTitle("Personnes")
                    .navigationBarItems(trailing: themeToggleButton)
                }
            }
        }
        .onAppear {
            loadData()
        }
        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
    }
    
    private var themeToggleButton: some View {
        Button(action: {
            themeManager.isDarkMode.toggle()
        }) {
            Image(systemName: themeManager.isDarkMode ? "sun.max.fill" : "moon.fill")
                .foregroundColor(.primary)
        }
    }
    
    private func loadData() {
        isLoading = true
        viewModel.fetchPeople()
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if !viewModel.people.isEmpty {
                isLoading = false
                timer.invalidate()
            }
        }
    }
}


struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Rechercher...", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if !text.isEmpty {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
        }
        .padding(.horizontal)
    }
}
