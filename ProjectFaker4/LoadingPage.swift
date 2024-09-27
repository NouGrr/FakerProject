//
//  LoadingPage.swift
//  ProjectFaker4
//
//  Created by Quentin Courrier on 9/27/24.
//

import Foundation
import SwiftUI

struct LoadingPage: View {
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            Image("Fa") // Assurez-vous que l'image "Fa" est dans vos assets
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
        }
    }
}

struct LoadingPage_Previews: PreviewProvider {
    static var previews: some View {
        LoadingPage()
    }
}



