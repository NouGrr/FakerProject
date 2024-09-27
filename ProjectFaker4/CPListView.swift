//
//  CPListView.swift
//  ProjectFaker4
//
//  Created by Quentin Courrier on 9/27/24.
//

import Foundation
import Alamofire
import SwiftUI

struct CPListView : View {
    @State private var isUnlocked = false
    @ObservedObject var viewModel = CPListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                if let comp = viewModel.comp {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Name: \(comp.name)")
                            .font(.headline)
                        
                        Text("Vat: \(comp.vat)")
                            .font(.subheadline)
                        
                        Text("Country: \(comp.country)")
                            .font(.subheadline)
                        
                    }
                    .padding(.vertical, 10)
                } else {
                    Text("Chargement dses informations")
                }
            }
            .navigationTitle("Entreprise")
            .onAppear {
                viewModel.fetchData(type: "Startup")
            }
        }
    }
}

struct CPListView_Previews: PreviewProvider {
    static var previews: some View {
        CPListView()
    }
}
