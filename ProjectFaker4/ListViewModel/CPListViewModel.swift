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
    @Published var comp: Company?
    @Published var isLoading = false
    @Published var error: String?
    
    func fetchData() {
        isLoading = true
        let urlString = "https://fakerapi.it/api/v1/companies?_quantity=1"
        
        guard let url = URL(string: urlString) else {
            self.error = "URL invalide"
            return
        }
        
        // Première requête pour voir la réponse brute
        AF.request(url)
            .responseData { [weak self] response in
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Réponse brute de l'API:")
                    print(str)
                }
                
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(CPResponse.self, from: data)
                        DispatchQueue.main.async {
                            self?.comp = response.data.first
                            self?.isLoading = false
                        }
                    } catch let decodingError {
                        print("Erreur de décodage: \(decodingError)")
                        if let decodingError = decodingError as? DecodingError {
                            switch decodingError {
                            case .keyNotFound(let key, let context):
                                print("Clé manquante: \(key.stringValue), path: \(context.codingPath)")
                            case .typeMismatch(let type, let context):
                                print("Type incorrect: attendu \(type), path: \(context.codingPath)")
                            default:
                                print("Autre erreur de décodage: \(decodingError.localizedDescription)")
                            }
                        }
                        DispatchQueue.main.async {
                            self?.error = decodingError.localizedDescription
                            self?.isLoading = false
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.error = error.localizedDescription
                        self?.isLoading = false
                    }
                }
            }
    }
}
