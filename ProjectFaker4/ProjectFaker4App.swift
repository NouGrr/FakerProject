//
//  ProjectFaker4App.swift
//  ProjectFaker4
//
//  Created by Quentin Courrier on 9/13/24.
//

import SwiftUI

@main
struct MyApp: App {
    @StateObject private var themeManager = ThemeManager() 

    var body: some Scene {
        WindowGroup {
            PersonListView(viewModel: PersonListViewModel())
                .tabItem {
                    Label("Personnes", systemImage: "person.3")
                }
                .environmentObject(themeManager)
        }
    }
}

