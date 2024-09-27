//
//  CCListView.swift
//  ProjectFaker4
//
//  Created by Quentin Courrier on 9/27/24.
//

import Foundation
import Alamofire
import SwiftUI

struct CreditCardListView : View {
    @State private var isUnlocked = false
    @ObservedObject var viewModel = CCListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                if let card = viewModel.card {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Type: \(card.type)")
                            .font(.headline)
                        
                        Text("Number: \(card.number)")
                            .font(.subheadline)
                        
                        Text("Expiration: \(card.expiration)")
                            .font(.subheadline)
                        
                    }
                    .padding(.vertical, 10)
                } else {
                    Text("Chargement dses informations")
                }
            }
            .navigationTitle("Credit Cards de merde")
            .onAppear {
                viewModel.fetchData(type: "visa")
            }
        }
    }
}

struct CCListView_Previews: PreviewProvider {
    static var previews: some View {
        CreditCardListView()
    }
}
