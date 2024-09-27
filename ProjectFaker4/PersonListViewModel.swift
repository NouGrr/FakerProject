import Foundation
import Alamofire

class PersonListViewModel: ObservableObject {
    @Published var people: [PersonIdentifiable] = []

    func fetchPeople() {
        let urlString = "https://fakerapi.it/api/v2/persons"
        AF.request(urlString)
            .validate() // Pour valider les réponses HTTP 200..<300 et les erreurs de contenu
            .responseDecodable(of: PersonResponse.self) { response in 
                switch response.result {
                case .success(let personResponse):
                    let persons = personResponse.data
                    var index : Int = 0
                    for person in persons {
                        self.people.append(PersonIdentifiable(idList: index, id: person.id, firstname: person.firstname, lastname: person.lastname, address: person.address, image: person.image, gender: person.gender))
                        index += 1
                    }
                case .failure(let error):
                    print("Erreur : \(error)")
                }
            }
    }
}



