//
//  CCListView.swift
//  ProjectFaker4
//
//  Created by Quentin Courrier on 9/27/24.
//

import Foundation
import Alamofire
import SwiftUI

struct CreditCardListView: View {
    @ObservedObject var viewModel: CCListViewModel
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
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
                Text("Chargement des informations")
            }
        }
        .navigationTitle("Credit Cards")
        .onAppear {
            viewModel.fetchData(type: "visa")
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
    }
}

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Retour")
            }
            .foregroundColor(themeManager.isDarkMode ? Color.green : Color.accentColor)

        }
    }
}
