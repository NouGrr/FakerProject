import Foundation

struct Person: Identifiable, Decodable {
    var id: UUID
    var firstname: String
    var lastname: String
    var address: Address
    var credit_card: CreditCard
    var image: String
}

struct Address: Decodable {
    var street: String
    var city: String
    var country: String
    var zipcode: String
}

struct CreditCard: Decodable {
    var cc_number: String
}

