//
//  PersonView.swift
//  ProjectFaker4
//
//  Created by Quentin Courrier on 9/13/24.
//

import Foundation
import SwiftUI

struct PersonListView: View {
    @ObservedObject var viewModel : PersonListViewModel
    
    var body: some View {
        NavigationView {
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
            .onAppear {
                viewModel.fetchPeople()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PersonListView(viewModel: PersonListViewModel())
    }
}
