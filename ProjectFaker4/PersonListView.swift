//
//  PersonListView.swift
//  ProjectFaker4
//
//  Created by Quentin Courrier on 9/13/24.
//

import Foundation
import SwiftUI

enum CreditCompanyMode: String, CaseIterable {
    case creditCards = "Voir les cartes de crédit"
    case companies = "Voir les entreprises"
}

struct PersonListView: View {
    @ObservedObject var viewModel: PersonListViewModel
    @StateObject private var themeManager = ThemeManager()
    @State private var isLoading = true
    @State private var searchText = ""
    @State private var selectedMode: CreditCompanyMode = .creditCards

    var body: some View {
        NavigationView {
            ZStack {
                if isLoading {
                    LoadingPage()
                } else {
                    VStack {
                        Picker("Sélectionnez une vue", selection: $selectedMode) {
                            ForEach(CreditCompanyMode.allCases, id: \.self) { mode in
                                Text(mode.rawValue).tag(mode)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        
                        SearchBar(text: $searchText)

                        List(viewModel.filteredPeople(searchText: searchText)) { person in
                            HStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("\(person.firstname) \(person.lastname), \(person.gender)")
                                        .font(.headline)
                                    
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text("Adresse: \(person.address.street), \(person.address.city), \(person.address.country)")
                                            .font(.subheadline)
                                        
                                        Text("Code postal: \(person.address.zipcode)")
                                            .font(.subheadline)
                                    }
                                    
                                    if selectedMode == .creditCards {
                                        NavigationLink(destination: CreditCardListView(viewModel: CCListViewModel()).environmentObject(themeManager)) {
                                            Image(systemName: "arrow.right.circle")
                                                .imageScale(.large)
                                                .foregroundColor(.primary)
                                        }
                                    } else {
                                        NavigationLink(destination: CPListView(viewModel: CPListViewModel()).environmentObject(themeManager)) {
                                            Image(systemName: "arrow.right.circle")
                                                .imageScale(.large)
                                                .foregroundColor(.primary)
                                        }
                                    }
                                }
                                
                                Spacer()
                                
                                AsyncImage(url: URL(string: person.image)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 60, height: 60)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 60, height: 60)
                                            .clipShape(Circle())
                                    case .failure:
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 60, height: 60)
                                            .foregroundColor(.gray)
                                    @unknown default:
                                        EmptyView()
                                    }
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

