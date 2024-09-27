//
//  CPListViewModel.swift
//  ProjectFaker4
//
//  Created by Quentin Courrier on 9/27/24.
//

import Foundation
import Alamofire
import SwiftUI

class CPListViewModel: ObservableObject {
    @Published var comp : CP?
        
    func fetchData(type: String){
        let urlString = "https://fakerapi.it/api/v2/companies"
        AF.request(urlString)
            .validate()
            .responseDecodable(of: CPResponse.self) {response in
                switch response.result {
                case .success(let CPResponse):
                    let cp = CPResponse.data
                    self.comp = cp[0]
                    
                case .failure(let error):
                    print("Erreur : \(error)")
                }
            }
    }
}

