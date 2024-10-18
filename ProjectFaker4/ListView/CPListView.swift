//
//  CPListView.swift
//  ProjectFaker4
//
//  Created by Quentin Courrier on 9/27/24.
//

import Foundation
import Alamofire
import SwiftUI

struct CPListView: View {
    @ObservedObject var viewModel = CPListViewModel()
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        List {
            if let comp = viewModel.comp {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Name: \(comp.name)")
                        .font(.headline)
                    
                    Text("Vat: \(comp.vat)")
                        .font(.subheadline)
                    
                    Text("Country: \(comp.country)")
                        .font(.subheadline)
                    
                    Text("Email: \(comp.email)")
                        .font(.subheadline)
                    
                    Text("Phone: \(comp.phone)")
                        .font(.subheadline)
                    
                    if let firstAddress = comp.addresses.first {
                        Group {
                            Text("Address:")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            
                            Text("\(firstAddress.street)")
                            Text("\(firstAddress.city), \(firstAddress.zipcode)")
                            Text("\(firstAddress.country) (\(firstAddress.country_code))")
                            
                            Text("Location: \(String(format: "%.6f", firstAddress.latitude)), \(String(format: "%.6f", firstAddress.longitude))")
                                .font(.caption)
                        }
                        .font(.subheadline)
                    }
                }
                .padding(.vertical, 10)
            } else {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.error {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    Text("Aucune donnée disponible")
                        .padding()
                }
            }
        }
        .navigationTitle("Entreprise")
        .onAppear {
            viewModel.fetchData()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton1())
    }
}

struct CustomBackButton1: View {
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

