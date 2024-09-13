//
//  CCListViewModel.swift
//  ProjectFaker4
//
//  Created by Quentin Courrier on 9/13/24.
//

import Foundation
import Alamofire
/*
class CCListViewModel: ObservableObject {
    @Published var card: [PersonIdentifiable] = []

    func fetchPeople() {
        let urlString = "https://fakerapi.it/api/v2/creditCards"
        AF.request(urlString)
            .validate() // Pour valider les réponses HTTP 200..<300 et les erreurs de contenu
            .responseDecodable(of: CCResponse.self) { response in // Notez le type [User].self ici
                switch response.result {
                case .success(let ccResponse):
                    let cc = ccResponse.data
                    var index : Int = 0
                    for creditcard in cc {
                        self.card.append(PersonIdentifiable(idList: cc.idList, id: cc.id, firstname: cc.firstname, lastname: cc.lastname, address: cc.address, image: cc.image, creditcard: cc.creditcard)
                        index += 1
                    }
                case .failure(let error):
                    print("Erreur : \(error)")
                }
            }
    }
}
*/
