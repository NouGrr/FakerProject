import Foundation
import Alamofire

class PersonListViewModel: ObservableObject {
    @Published var people: [PersonIdentifiable] = []

    func fetchPeople() {
        let urlString = "https://fakerapi.it/api/v2/persons"
        AF.request(urlString)
            .validate()
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
    
    func filteredPeople(searchText: String) -> [PersonIdentifiable] {
        if searchText.isEmpty {
            return people
        } else {
            return people.filter { person in
                person.firstname.lowercased().contains(searchText.lowercased()) ||
                person.lastname.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
