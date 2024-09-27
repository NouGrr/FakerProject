//
//  CCListViewModel.swift
//  ProjectFaker4
//
//  Created by Quentin Courrier on 9/13/24.
//

import Foundation
import Alamofire
import SwiftUI

class CCListViewModel: ObservableObject {
    @Published var card : CreditCard?
        
    func fetchData(type: String){
        let urlString = "https://fakerapi.it/api/v2/creditCards"
        AF.request(urlString)
            .validate()
            .responseDecodable(of: CCResponse.self) {response in
                switch response.result {
                case .success(let CCResponse):
                    let cb = CCResponse.data
                    self.card = cb[0]
                    
                case .failure(let error):
                    print("Erreur : \(error)")
                }
            }
    }
}

