//
//  PersonView.swift
//  ProjectFaker4
//
//  Created by Quentin Courrier on 9/13/24.
//

import Foundation
import SwiftUI

struct PersonListView: View {
    @ObservedObject var viewModel: PersonListViewModel
    @State private var isLoading = true
    
    var body: some View {
        NavigationView {
            ZStack {
                if isLoading {
                    LoadingPage()
                } else {
                    List(viewModel.people) { person in
                        VStack(alignment: .leading, spacing: 10) {
                            Text("\(person.firstname) \(person.lastname), \(person.gender)")
                                .font(.headline)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Adresse: \(person.address.street), \(person.address.city), \(person.address.country)")
                                    .font(.subheadline)
                                
                                Text("Code postal: \(person.address.zipcode)")
                                    .font(.subheadline)
                            }
                            
                            NavigationLink(destination: CreditCardListView(viewModel: CCListViewModel())) {
                                Image(systemName: "arrow.right.circle")
                                    .imageScale(.large)
                                    .foregroundColor(.black)
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
                    .navigationTitle("Personnes")
                }
            }
        }
        .onAppear {
            loadData()
        }
    }
    
    private func loadData() {
        isLoading = true
        viewModel.fetchPeople()
        
        // Utilisez un timer pour vérifier périodiquement si les données sont chargées
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if !viewModel.people.isEmpty {
                isLoading = false
                timer.invalidate()
            }
        }
    }
}
