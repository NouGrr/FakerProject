import SwiftUI

struct PersonListView: View {
    @StateObject var personController = PersonController()
    
    var body: some View {
        NavigationView {
            List(personController.people) { person in
                VStack(alignment: .leading, spacing: 10) {
                    Text("\(person.firstname) \(person.lastname)")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Adresse: \(person.address.street), \(person.address.city), \(person.address.country)")
                            .font(.subheadline)
                        
                        Text("Code postal: \(person.address.zipcode)")
                            .font(.subheadline)
                    }
                    
                    Text("Carte de Crédit: \(person.credit_card.cc_number)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    AsyncImage(url: URL(string: person.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                    } placeholder: {
                        ProgressView()
                    }
                }
                .padding(.vertical, 10)
            }
            .navigationTitle("Personnes")
            .onAppear {
                personController.fetchPeople()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PersonListView()
    }
}

