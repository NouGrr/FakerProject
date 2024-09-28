//
//  ThemeManager.swift
//  ProjectFaker4
//
//  Created by Quentin Courrier on 9/28/24.
//

import Foundation
import SwiftUI

class ThemeManager: ObservableObject {
    @Published var isDarkMode: Bool {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        }
    }
    
    init() {
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    }
}
