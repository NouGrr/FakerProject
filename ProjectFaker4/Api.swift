import Foundation

class PersonController: ObservableObject {
    @Published var people: [Person] = []

    func fetchPeople() {
        let urlString = "https://fakerapi.it/api/v2/persons?_locale=fr_FR&_quantity=10"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching people: \(error)")
                return
            }

            guard let data = data else {
                print("No data returned")
                return
            }

            do {
                // Décode les données reçues en un dictionnaire
                let response = try JSONDecoder().decode(PersonResponse.self, from: data)
                
                // Extraire les personnes et mettre à jour l'interface utilisateur
                DispatchQueue.main.async {
                    self.people = response.data
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        task.resume()
    }
}

// Assurez-vous d'avoir une structure pour décoder la réponse complète
struct PersonResponse: Decodable {
    var data: [Person]
}

